	.text
	.file	"Hamada64.c"
	.globl	main                            // -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   // @main
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-32]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	str	x28, [sp, #16]                  // 8-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 32
	.cfi_offset w28, -16
	.cfi_offset w30, -24
	.cfi_offset w29, -32
	.cfi_remember_state
	sub	sp, sp, #17, lsl #12            // =69632
	sub	sp, sp, #2160
	sub	x8, x29, #24
	str	x8, [sp, #56]                   // 8-byte Folded Spill
	add	x9, sp, #3144
	str	x9, [sp, #48]                   // 8-byte Folded Spill
	str	wzr, [x8, #20]
	adrp	x0, .L.str
	add	x0, x0, :lo12:.L.str
	adrp	x1, .L.str.1
	add	x1, x1, :lo12:.L.str.1
	bl	fopen
	ldr	x8, [sp, #56]                   // 8-byte Folded Reload
	str	x0, [x8, #8]
	ldr	x8, [x8, #8]
	cbnz	x8, .LBB0_2
	b	.LBB0_1
.LBB0_1:
	adrp	x8, :got:stderr
	ldr	x8, [x8, :got_lo12:stderr]
	ldr	x0, [x8]
	adrp	x1, .L.str.2
	add	x1, x1, :lo12:.L.str.2
	adrp	x2, .L.str
	add	x2, x2, :lo12:.L.str
	bl	fprintf
	mov	w0, #1                          // =0x1
	add	sp, sp, #17, lsl #12            // =69632
	add	sp, sp, #2160
	.cfi_def_cfa wsp, 32
	ldr	x28, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #32             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w28
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB0_2:
	.cfi_restore_state
	ldr	x8, [sp, #56]                   // 8-byte Folded Reload
	ldr	x0, [x8, #8]
	bl	fclose
	ldr	x8, [sp, #56]                   // 8-byte Folded Reload
	mov	w9, #1                          // =0x1
	strb	w9, [x8, #7]
	str	wzr, [x8]
	b	.LBB0_3
.LBB0_3:                                // =>This Loop Header: Depth=1
                                        //     Child Loop BB0_5 Depth 2
                                        //     Child Loop BB0_16 Depth 2
                                        //     Child Loop BB0_28 Depth 2
                                        //       Child Loop BB0_30 Depth 3
	str	wzr, [sp, #6228]
	adrp	x0, .L.str
	add	x0, x0, :lo12:.L.str
	adrp	x1, .L.str.1
	add	x1, x1, :lo12:.L.str.1
	bl	fopen
	ldr	x8, [sp, #56]                   // 8-byte Folded Reload
	str	x0, [x8, #8]
	ldr	x8, [x8, #8]
	cbz	x8, .LBB0_14
	b	.LBB0_4
.LBB0_4:                                //   in Loop: Header=BB0_3 Depth=1
	b	.LBB0_5
.LBB0_5:                                //   Parent Loop BB0_3 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp, #56]                   // 8-byte Folded Reload
	ldr	x2, [x8, #8]
	add	x0, sp, #1, lsl #12             // =4096
	add	x0, x0, #1108
	mov	w1, #1024                       // =0x400
	bl	fgets
	mov	w8, #0                          // =0x0
	str	w8, [sp, #44]                   // 4-byte Folded Spill
	cbz	x0, .LBB0_7
	b	.LBB0_6
.LBB0_6:                                //   in Loop: Header=BB0_5 Depth=2
	ldr	w8, [sp, #6228]
	subs	w8, w8, #256
	cset	w8, lt
	str	w8, [sp, #44]                   // 4-byte Folded Spill
	b	.LBB0_7
.LBB0_7:                                //   in Loop: Header=BB0_5 Depth=2
	ldr	w8, [sp, #44]                   // 4-byte Folded Reload
	tbz	w8, #0, .LBB0_13
	b	.LBB0_8
.LBB0_8:                                //   in Loop: Header=BB0_5 Depth=2
	add	x0, sp, #1, lsl #12             // =4096
	add	x0, x0, #1108
	str	x0, [sp, #32]                   // 8-byte Folded Spill
	adrp	x1, .L.str.3
	add	x1, x1, :lo12:.L.str.3
	bl	strcspn
	ldr	x9, [sp, #32]                   // 8-byte Folded Reload
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	add	x9, x9, x0
	strb	wzr, [x9]
	ldrb	w8, [x8, #2060]
	cbnz	w8, .LBB0_10
	b	.LBB0_9
.LBB0_9:                                //   in Loop: Header=BB0_5 Depth=2
	b	.LBB0_5
.LBB0_10:                               //   in Loop: Header=BB0_5 Depth=2
	add	x0, sp, #1, lsl #12             // =4096
	add	x0, x0, #1108
	mov	w1, #32                         // =0x20
	bl	strchr
	cbz	x0, .LBB0_12
	b	.LBB0_11
.LBB0_11:                               //   in Loop: Header=BB0_5 Depth=2
	b	.LBB0_5
.LBB0_12:                               //   in Loop: Header=BB0_5 Depth=2
	ldrsw	x9, [sp, #6228]
	add	x8, sp, #1, lsl #12             // =4096
	add	x8, x8, #2136
	str	x8, [sp, #24]                   // 8-byte Folded Spill
	add	x0, x8, x9, lsl #8
	add	x1, sp, #1, lsl #12             // =4096
	add	x1, x1, #1108
	mov	x2, #255                        // =0xff
	bl	strncpy
	ldr	x8, [sp, #24]                   // 8-byte Folded Reload
	ldrsw	x9, [sp, #6228]
	add	x8, x8, x9, lsl #8
	strb	wzr, [x8, #255]
	ldr	w8, [sp, #6228]
	add	w8, w8, #1
	str	w8, [sp, #6228]
	b	.LBB0_5
.LBB0_13:                               //   in Loop: Header=BB0_3 Depth=1
	ldr	x8, [sp, #56]                   // 8-byte Folded Reload
	ldr	x0, [x8, #8]
	bl	fclose
	b	.LBB0_14
.LBB0_14:                               //   in Loop: Header=BB0_3 Depth=1
	ldr	x9, [sp, #48]                   // 8-byte Folded Reload
	mov	w8, #1                          // =0x1
	strb	w8, [x9, #2059]
	adrp	x0, .L.str.4
	add	x0, x0, :lo12:.L.str.4
	adrp	x1, .L.str.1
	add	x1, x1, :lo12:.L.str.1
	bl	popen
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	str	x0, [x8, #2048]
	ldr	x8, [x8, #2048]
	cbz	x8, .LBB0_23
	b	.LBB0_15
.LBB0_15:                               //   in Loop: Header=BB0_3 Depth=1
	b	.LBB0_16
.LBB0_16:                               //   Parent Loop BB0_3 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	ldr	x2, [x8, #2048]
	add	x0, sp, #1, lsl #12             // =4096
	add	x0, x0, #72
	mov	w1, #1024                       // =0x400
	bl	fgets
	cbz	x0, .LBB0_22
	b	.LBB0_17
.LBB0_17:                               //   in Loop: Header=BB0_16 Depth=2
	add	x0, sp, #1, lsl #12             // =4096
	add	x0, x0, #72
	adrp	x1, .L.str.5
	add	x1, x1, :lo12:.L.str.5
	bl	strstr
	cbz	x0, .LBB0_21
	b	.LBB0_18
.LBB0_18:                               //   in Loop: Header=BB0_16 Depth=2
	add	x0, sp, #1, lsl #12             // =4096
	add	x0, x0, #72
	adrp	x1, .L.str.6
	add	x1, x1, :lo12:.L.str.6
	bl	strstr
	cbz	x0, .LBB0_20
	b	.LBB0_19
.LBB0_19:                               //   in Loop: Header=BB0_3 Depth=1
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	strb	wzr, [x8, #2059]
	b	.LBB0_22
.LBB0_20:                               //   in Loop: Header=BB0_16 Depth=2
	b	.LBB0_21
.LBB0_21:                               //   in Loop: Header=BB0_16 Depth=2
	b	.LBB0_16
.LBB0_22:                               //   in Loop: Header=BB0_3 Depth=1
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	ldr	x0, [x8, #2048]
	bl	pclose
	b	.LBB0_23
.LBB0_23:                               //   in Loop: Header=BB0_3 Depth=1
	ldr	x9, [sp, #56]                   // 8-byte Folded Reload
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	ldrb	w8, [x8, #2059]
	and	w8, w8, #0x1
	ldrb	w9, [x9, #7]
	and	w9, w9, #0x1
	subs	w8, w8, w9
	b.eq	.LBB0_25
	b	.LBB0_24
.LBB0_24:                               //   in Loop: Header=BB0_3 Depth=1
	adrp	x0, .L.str.7
	add	x0, x0, :lo12:.L.str.7
	bl	printf
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	ldr	x9, [sp, #56]                   // 8-byte Folded Reload
	ldrb	w8, [x8, #2059]
	and	w8, w8, #0x1
	strb	w8, [x9, #7]
	b	.LBB0_25
.LBB0_25:                               //   in Loop: Header=BB0_3 Depth=1
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	ldrb	w8, [x8, #2059]
	tbz	w8, #0, .LBB0_45
	b	.LBB0_26
.LBB0_26:                               //   in Loop: Header=BB0_3 Depth=1
	adrp	x0, .L.str.8
	add	x0, x0, :lo12:.L.str.8
	adrp	x1, .L.str.1
	add	x1, x1, :lo12:.L.str.1
	bl	popen
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	str	x0, [x8, #2048]
	add	x0, sp, #3144
	mov	x2, #1024                       // =0x400
	mov	w1, wzr
	bl	memset
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	ldr	x8, [x8, #2048]
	cbz	x8, .LBB0_37
	b	.LBB0_27
.LBB0_27:                               //   in Loop: Header=BB0_3 Depth=1
	b	.LBB0_28
.LBB0_28:                               //   Parent Loop BB0_3 Depth=1
                                        // =>  This Loop Header: Depth=2
                                        //       Child Loop BB0_30 Depth 3
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	ldr	x2, [x8, #2048]
	add	x0, sp, #2120
	mov	w1, #1024                       // =0x400
	bl	fgets
	cbz	x0, .LBB0_36
	b	.LBB0_29
.LBB0_29:                               //   in Loop: Header=BB0_28 Depth=2
	str	wzr, [sp, #2116]
	b	.LBB0_30
.LBB0_30:                               //   Parent Loop BB0_3 Depth=1
                                        //     Parent Loop BB0_28 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	ldr	w8, [sp, #2116]
	ldr	w9, [sp, #6228]
	subs	w8, w8, w9
	b.ge	.LBB0_35
	b	.LBB0_31
.LBB0_31:                               //   in Loop: Header=BB0_30 Depth=3
	ldrsw	x9, [sp, #2116]
	add	x8, sp, #1, lsl #12             // =4096
	add	x8, x8, #2136
	add	x1, x8, x9, lsl #8
	add	x0, sp, #2120
	bl	strstr
	cbz	x0, .LBB0_33
	b	.LBB0_32
.LBB0_32:                               //   in Loop: Header=BB0_30 Depth=3
	ldrsw	x9, [sp, #2116]
	add	x8, sp, #1, lsl #12             // =4096
	add	x8, x8, #2136
	add	x1, x8, x9, lsl #8
	add	x0, sp, #3144
	mov	x2, #1023                       // =0x3ff
	bl	strncpy
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	strb	wzr, [x8, #1023]
	b	.LBB0_33
.LBB0_33:                               //   in Loop: Header=BB0_30 Depth=3
	b	.LBB0_34
.LBB0_34:                               //   in Loop: Header=BB0_30 Depth=3
	ldr	w8, [sp, #2116]
	add	w8, w8, #1
	str	w8, [sp, #2116]
	b	.LBB0_30
.LBB0_35:                               //   in Loop: Header=BB0_28 Depth=2
	b	.LBB0_28
.LBB0_36:                               //   in Loop: Header=BB0_3 Depth=1
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	ldr	x0, [x8, #2048]
	bl	pclose
	b	.LBB0_37
.LBB0_37:                               //   in Loop: Header=BB0_3 Depth=1
	add	x0, sp, #3144
	bl	strlen
	subs	x8, x0, #0
	b.ls	.LBB0_41
	b	.LBB0_38
.LBB0_38:                               //   in Loop: Header=BB0_3 Depth=1
	ldr	x8, [sp, #56]                   // 8-byte Folded Reload
	ldr	w8, [x8]
	subs	w8, w8, #1
	b.eq	.LBB0_40
	b	.LBB0_39
.LBB0_39:                               //   in Loop: Header=BB0_3 Depth=1
	adrp	x0, .L.str.9
	add	x0, x0, :lo12:.L.str.9
	add	x1, sp, #3144
	bl	printf
	add	x0, sp, #1092
	str	x0, [sp, #16]                   // 8-byte Folded Spill
	mov	x1, #1024                       // =0x400
	adrp	x2, .L.str.10
	add	x2, x2, :lo12:.L.str.10
	adrp	x3, .L.str.11
	add	x3, x3, :lo12:.L.str.11
	bl	snprintf
	ldr	x0, [sp, #16]                   // 8-byte Folded Reload
	bl	system
	ldr	x9, [sp, #56]                   // 8-byte Folded Reload
	mov	w8, #1                          // =0x1
	str	w8, [x9]
	b	.LBB0_40
.LBB0_40:                               //   in Loop: Header=BB0_3 Depth=1
	b	.LBB0_44
.LBB0_41:                               //   in Loop: Header=BB0_3 Depth=1
	ldr	x8, [sp, #56]                   // 8-byte Folded Reload
	ldr	w8, [x8]
	subs	w8, w8, #2
	b.eq	.LBB0_43
	b	.LBB0_42
.LBB0_42:                               //   in Loop: Header=BB0_3 Depth=1
	adrp	x0, .L.str.12
	add	x0, x0, :lo12:.L.str.12
	bl	printf
	add	x0, sp, #68
	str	x0, [sp, #8]                    // 8-byte Folded Spill
	mov	x1, #1024                       // =0x400
	adrp	x2, .L.str.10
	add	x2, x2, :lo12:.L.str.10
	adrp	x3, .L.str.13
	add	x3, x3, :lo12:.L.str.13
	bl	snprintf
	ldr	x0, [sp, #8]                    // 8-byte Folded Reload
	bl	system
	ldr	x9, [sp, #56]                   // 8-byte Folded Reload
	mov	w8, #2                          // =0x2
	str	w8, [x9]
	b	.LBB0_43
.LBB0_43:                               //   in Loop: Header=BB0_3 Depth=1
	b	.LBB0_44
.LBB0_44:                               //   in Loop: Header=BB0_3 Depth=1
	b	.LBB0_45
.LBB0_45:                               //   in Loop: Header=BB0_3 Depth=1
	mov	w0, #2                          // =0x2
	bl	sleep
	b	.LBB0_3
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        // -- End function
	.type	.L.str,@object                  // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"/storage/emulated/0/HAMADA/game.txt"
	.size	.L.str, 36

	.type	.L.str.1,@object                // @.str.1
.L.str.1:
	.asciz	"r"
	.size	.L.str.1, 2

	.type	.L.str.2,@object                // @.str.2
.L.str.2:
	.asciz	"Error: %s not found\n"
	.size	.L.str.2, 21

	.type	.L.str.3,@object                // @.str.3
.L.str.3:
	.asciz	"\n"
	.size	.L.str.3, 2

	.type	.L.str.4,@object                // @.str.4
.L.str.4:
	.asciz	"dumpsys window"
	.size	.L.str.4, 15

	.type	.L.str.5,@object                // @.str.5
.L.str.5:
	.asciz	"mScreenOn"
	.size	.L.str.5, 10

	.type	.L.str.6,@object                // @.str.6
.L.str.6:
	.asciz	"false"
	.size	.L.str.6, 6

	.type	.L.str.7,@object                // @.str.7
.L.str.7:
	.asciz	"Screen status changed\n"
	.size	.L.str.7, 23

	.type	.L.str.8,@object                // @.str.8
.L.str.8:
	.asciz	"dumpsys window | grep package"
	.size	.L.str.8, 30

	.type	.L.str.9,@object                // @.str.9
.L.str.9:
	.asciz	"Game package detected: %s\n"
	.size	.L.str.9, 27

	.type	.L.str.10,@object               // @.str.10
.L.str.10:
	.asciz	"sh %s"
	.size	.L.str.10, 6

	.type	.L.str.11,@object               // @.str.11
.L.str.11:
	.asciz	"/data/adb/modules/HamadaAI/Scripts/game.sh"
	.size	.L.str.11, 43

	.type	.L.str.12,@object               // @.str.12
.L.str.12:
	.asciz	"Non-game package detected\n"
	.size	.L.str.12, 27

	.type	.L.str.13,@object               // @.str.13
.L.str.13:
	.asciz	"/data/adb/modules/HamadaAI/Scripts/normal.sh"
	.size	.L.str.13, 45

	.ident	"clang version 19.1.7"
	.section	".note.GNU-stack","",@progbits
