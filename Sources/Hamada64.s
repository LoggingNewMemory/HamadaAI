    .section .data
GAME_LIST:
    .asciz "/storage/emulated/0/HAMADA/game.txt"
GAME_SCRIPT:
    .asciz "/data/adb/modules/HamadaAI/Scripts/game.sh"
NORMAL_SCRIPT:
    .asciz "/data/adb/modules/HamadaAI/Scripts/normal.sh"
ERR_MSG:
    .asciz "Error: /storage/emulated/0/HAMADA/game.txt not found\n"
MODE_R:
    .asciz "r"
GREP_O:
    .asciz "grep -o"
SPACE_E:
    .asciz " -e "
SCREEN_CMD:
    .asciz "dumpsys window | grep mScreenOn | grep false"
    // PKG_CMD_PREFIX updated: Added a pipe after "grep package" so the filter expression is applied correctly.
PKG_CMD_PREFIX:
    .asciz "dumpsys window | grep package | "
PKG_CMD_SUFFIX:
    .asciz " | tail -1"
SCREEN_CHANGED_MSG:
    .asciz "Screen status changed\n"
GAME_DETECTED_MSG:
    .asciz "Game package detected: "
NON_GAME_MSG:
    .asciz "Non-game package detected\n"
SH_CMD_PREFIX:
    .asciz "sh "
game_str:
    .asciz "game"
normal_str:
    .asciz "normal"

    .section .bss
    .lcomm filter_buf, 256         // Holds the filter expression.
    .lcomm line_buffer, 256          // Temporary buffer for reading lines.
    .lcomm curr_screen, 256          // Current screen status string.
    .lcomm prev_screen, 256          // Previous screen status string.
    .lcomm window_buf, 256           // Output of package detection command.
    .lcomm cmd_buf, 512              // Command buffer for building dynamic commands.
    .lcomm last_executed, 16         // Holds either "game", "normal", or empty.

    .section .text
    .global main
main:
    // Function prologue
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    // Check if GAME_LIST exists: fopen(GAME_LIST, "r")
    adrp    x0, GAME_LIST
    add     x0, x0, :lo12:GAME_LIST
    adrp    x1, MODE_R
    add     x1, x1, :lo12:MODE_R
    bl      fopen
    cbz     x0, file_not_found   // if fopen returned NULL, file not found
    // Close file after checking existence
    mov     x1, x0
    bl      fclose

    // Initialize prev_screen and last_executed to empty strings (first byte = 0)
    adrp    x0, prev_screen
    add     x0, x0, :lo12:prev_screen
    mov     w1, #0
    strb    w1, [x0]
    adrp    x0, last_executed
    add     x0, x0, :lo12:last_executed
    strb    w1, [x0]

loop_start:
    // === Build the filter expression (app_list_filter) ===
    // Initialize filter_buf with "grep -o"
    adrp    x0, filter_buf
    add     x0, x0, :lo12:filter_buf
    adrp    x1, GREP_O
    add     x1, x1, :lo12:GREP_O
    bl      strcpy

    // Open GAME_LIST file for reading
    adrp    x0, GAME_LIST
    add     x0, x0, :lo12:GAME_LIST
    adrp    x1, MODE_R
    add     x1, x1, :lo12:MODE_R
    bl      fopen
    cbz     x0, file_open_error   // if cannot open, exit
    mov     x19, x0             // save FILE* in x19

build_filter_loop:
    // Read a line into line_buffer: fgets(line_buffer, 256, file)
    adrp    x0, line_buffer
    add     x0, x0, :lo12:line_buffer
    mov     x1, #256
    mov     x2, x19
    bl      fgets
    cbz     x0, end_build_filter  // if fgets returns NULL, end loop

    // Check if line is nonempty: if first char == 0 then skip
    adrp    x3, line_buffer
    add     x3, x3, :lo12:line_buffer
    ldrb    w4, [x3]
    cmp     w4, #0
    beq     build_filter_loop   // skip if empty

    // Scan the line to see if it contains a space (0x20)
    mov     x5, x3              // pointer to start of line_buffer
check_space_loop:
    ldrb    w6, [x5], #1
    cbz     w6, no_space_found  // reached end-of-string, no space found
    cmp     w6, #' '           // compare with ASCII space
    beq     space_found
    b       check_space_loop
space_found:
    // If a space was found, skip this line
    b       build_filter_loop
no_space_found:
    // Append " -e " to filter_buf
    adrp    x0, filter_buf
    add     x0, x0, :lo12:filter_buf
    adrp    x1, SPACE_E
    add     x1, x1, :lo12:SPACE_E
    bl      strcat

    // Remove any newline character from line_buffer.
    adrp    x7, line_buffer
    add     x7, x7, :lo12:line_buffer
remove_newline_loop:
    ldrb    w8, [x7]
    cbz     w8, newline_removed
    cmp     w8, #'\n'
    beq     newline_found
    add     x7, x7, #1
    b       remove_newline_loop
newline_found:
    mov     w8, #0
    strb    w8, [x7]
newline_removed:
    // Append the package (line_buffer) to filter_buf
    adrp    x0, filter_buf
    add     x0, x0, :lo12:filter_buf
    adrp    x1, line_buffer
    add     x1, x1, :lo12:line_buffer
    bl      strcat
    b       build_filter_loop

end_build_filter:
    // Close the game list file
    mov     x0, x19
    bl      fclose

    // === Check screen status ===
    // Execute: "dumpsys window | grep mScreenOn | grep false"
    adrp    x0, SCREEN_CMD
    add     x0, x0, :lo12:SCREEN_CMD
    adrp    x1, MODE_R
    add     x1, x1, :lo12:MODE_R
    bl      popen
    mov     x20, x0            // pipe pointer for screen command
    adrp    x0, curr_screen
    add     x0, x0, :lo12:curr_screen
    mov     x1, #256
    mov     x2, x20
    bl      fgets             // read output into curr_screen
    // Close the pipe
    mov     x0, x20
    bl      pclose

    // Compare curr_screen with prev_screen using strcmp
    adrp    x0, curr_screen
    add     x0, x0, :lo12:curr_screen
    adrp    x1, prev_screen
    add     x1, x1, :lo12:prev_screen
    bl      strcmp
    cmp     w0, #0
    beq     skip_screen_change
    // If different, update prev_screen and print change message
    adrp    x0, prev_screen
    add     x0, x0, :lo12:prev_screen
    adrp    x1, curr_screen
    add     x1, x1, :lo12:curr_screen
    bl      strcpy
    adrp    x0, SCREEN_CHANGED_MSG
    add     x0, x0, :lo12:SCREEN_CHANGED_MSG
    bl      puts

skip_screen_change:
    // Only proceed with app detection if screen is ON.
    // (Here we assume that a nonempty curr_screen means the screen is off.)
    adrp    x0, curr_screen
    add     x0, x0, :lo12:curr_screen
    ldrb    w1, [x0]
    cbnz    w1, skip_app_detection

    // === Detect current foreground app ===
    // Build command: cmd_buf = PKG_CMD_PREFIX + filter_buf + PKG_CMD_SUFFIX
    adrp    x0, cmd_buf
    add     x0, x0, :lo12:cmd_buf
    adrp    x1, PKG_CMD_PREFIX
    add     x1, x1, :lo12:PKG_CMD_PREFIX
    bl      strcpy
    adrp    x0, cmd_buf
    add     x0, x0, :lo12:cmd_buf
    adrp    x1, filter_buf
    add     x1, x1, :lo12:filter_buf
    bl      strcat
    adrp    x0, cmd_buf
    add     x0, x0, :lo12:cmd_buf
    adrp    x1, PKG_CMD_SUFFIX
    add     x1, x1, :lo12:PKG_CMD_SUFFIX
    bl      strcat

    // Clear window_buf before executing popen
    adrp    x0, window_buf
    add     x0, x0, :lo12:window_buf
    mov     w1, #0
    strb    w1, [x0]

    // Execute the package-detection command via popen
    adrp    x0, cmd_buf
    add     x0, x0, :lo12:cmd_buf
    adrp    x1, MODE_R
    add     x1, x1, :lo12:MODE_R
    bl      popen
    mov     x21, x0            // save pipe pointer in x21
    adrp    x0, window_buf
    add     x0, x0, :lo12:window_buf
    mov     x1, #256
    mov     x2, x21
    bl      fgets             // read output into window_buf
    mov     x0, x21
    bl      pclose

    // Check if window_buf is empty or just a newline; if so, go to non-game branch.
    adrp    x0, window_buf
    add     x0, x0, :lo12:window_buf
    ldrb    w1, [x0]
    cmp     w1, #'\n'
    beq     non_game_detected
    cbz     w1, non_game_detected

    // ---- GAME PACKAGE DETECTED ----
    // Compare last_executed with "game"
    adrp    x0, last_executed
    add     x0, x0, :lo12:last_executed
    adrp    x1, game_str
    add     x1, x1, :lo12:game_str
    bl      strcmp
    cbz     w0, skip_app_detection   // already executed game script?
    // Print "Game package detected: " and then the package info
    adrp    x0, GAME_DETECTED_MSG
    add     x0, x0, :lo12:GAME_DETECTED_MSG
    bl      puts
    adrp    x0, window_buf
    add     x0, x0, :lo12:window_buf
    bl      puts
    // Build command: "sh " + GAME_SCRIPT
    adrp    x0, cmd_buf
    add     x0, x0, :lo12:cmd_buf
    adrp    x1, SH_CMD_PREFIX
    add     x1, x1, :lo12:SH_CMD_PREFIX
    bl      strcpy
    adrp    x0, cmd_buf
    add     x0, x0, :lo12:cmd_buf
    adrp    x1, GAME_SCRIPT
    add     x1, x1, :lo12:GAME_SCRIPT
    bl      strcat
    // Execute the game script via system()
    adrp    x0, cmd_buf
    add     x0, x0, :lo12:cmd_buf
    bl      system
    // Update last_executed = "game"
    adrp    x0, last_executed
    add     x0, x0, :lo12:last_executed
    adrp    x1, game_str
    add     x1, x1, :lo12:game_str
    bl      strcpy
    b       end_app_detection

non_game_detected:
    // ---- NON-GAME PACKAGE DETECTED ----
    // Compare last_executed with "normal"
    adrp    x0, last_executed
    add     x0, x0, :lo12:last_executed
    adrp    x1, normal_str
    add     x1, x1, :lo12:normal_str
    bl      strcmp
    cbz     w0, end_app_detection   // already executed normal script?
    // Print "Non-game package detected"
    adrp    x0, NON_GAME_MSG
    add     x0, x0, :lo12:NON_GAME_MSG
    bl      puts
    // Build command: "sh " + NORMAL_SCRIPT
    adrp    x0, cmd_buf
    add     x0, x0, :lo12:cmd_buf
    adrp    x1, SH_CMD_PREFIX
    add     x1, x1, :lo12:SH_CMD_PREFIX
    bl      strcpy
    adrp    x0, cmd_buf
    add     x0, x0, :lo12:cmd_buf
    adrp    x1, NORMAL_SCRIPT
    add     x1, x1, :lo12:NORMAL_SCRIPT
    bl      strcat
    // Execute the normal script via system()
    adrp    x0, cmd_buf
    add     x0, x0, :lo12:cmd_buf
    bl      system
    // Update last_executed = "normal"
    adrp    x0, last_executed
    add     x0, x0, :lo12:last_executed
    adrp    x1, normal_str
    add     x1, x1, :lo12:normal_str
    bl      strcpy

end_app_detection:
skip_app_detection:
    // Sleep for 2 seconds (sleep(2))
    mov     x0, #2
    bl      sleep

    // Clear filter_buf (set first byte = 0) for next iteration
    adrp    x0, filter_buf
    add     x0, x0, :lo12:filter_buf
    mov     w1, #0
    strb    w1, [x0]

    b       loop_start

file_not_found:
    // Print error and exit(1)
    adrp    x0, ERR_MSG
    add     x0, x0, :lo12:ERR_MSG
    bl      puts
    mov     x0, #1
    bl      exit

file_open_error:
    adrp    x0, ERR_MSG
    add     x0, x0, :lo12:ERR_MSG
    bl      puts
    mov     x0, #1
    bl      exit

    // Function epilogue (never reached)
    mov     x0, #0
    bl      exit
