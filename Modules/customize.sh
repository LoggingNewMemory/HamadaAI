LATESTARTSERVICE=true

ui_print "🗡--------------------------------🗡"
ui_print "              Hamada AI             "
ui_print "🗡--------------------------------🗡"
ui_print "         By:Kanagawa Yamada         "
ui_print "------------------------------------"
ui_print " "
sleep 1.5

ui_print "------------------------------------"
ui_print "      SNAPDRAGON | MEDIATEK         "
ui_print "          EXYNOS | UniSoc           "
ui_print "------------------------------------"
ui_print "DO NOT COMBINE WITH ANY PERF MODULE!"
ui_print "------------------------------------"
ui_print " "
sleep 1.5


ui_print "-----------------📱-----------------"
ui_print "            DEVICE INFO             "
ui_print "-----------------📱-----------------"
ui_print "DEVICE : $(getprop ro.build.product) "
ui_print "MODEL : $(getprop ro.product.model) "
ui_print "MANUFACTURE : $(getprop ro.product.system.manufacturer) "
ui_print "PROC : $(getprop ro.product.board) "
ui_print "CPU : $(getprop ro.hardware) "
ui_print "ANDROID VER : $(getprop ro.build.version.release) "
ui_print "KERNEL : $(uname -r) "
ui_print "RAM : $(free | grep Mem |  awk '{print $2}') "
ui_print " "
sleep 1.5

ui_print "-----------------🗡-----------------"
ui_print "            MODULE INFO             "
ui_print "-----------------🗡-----------------"
ui_print "Name : HamadaAI"
ui_print "Version : BETA-2.0"
ui_print "Support Root : Magisk / KernelSU / APatch"
ui_print " "
sleep 1.5

ui_print "      INSTALLING        "
ui_print " "
sleep 1.5


mkdir -p $MODPATH/system/bin

mkdir -p /sdcard/HAMADA
unzip -o "$ZIPFILE" 'Scripts/*' -d $MODPATH >&2
cp -r "$MODPATH"/game.txt /sdcard/HAMADA >/dev/null 2>&1

unzip -o "$ZIPFILE" 'Hamada64' -d $MODPATH/system/bin >&2

set_perm_recursive $MODPATH 0 0 0755 0644
set_perm $MODPATH/system/bin/Hamada64 0 0 0755 0755
