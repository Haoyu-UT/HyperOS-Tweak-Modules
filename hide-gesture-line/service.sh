#!/system/bin/sh
# Hide the gesture line on every boot, in case Settings or an OTA turned it back on.
#
# Disabling or removing a module runs none of its scripts, so the guard, a boot script outside
# the module, shows the line again once the module is off. It is installed first, so the line is
# never hidden without a way back.

MODDIR=${0%/*}
GUARD=/data/adb/service.d/hyperos_hide_gesture_line_guard.sh

mkdir -p ${GUARD%/*}
cp "$MODDIR/guard.sh" $GUARD && chmod 755 $GUARD || exit 0

until [ "$(getprop sys.boot_completed)" = "1" ]; do sleep 2; done
[ "$(settings get global hide_gesture_line)" = "1" ] || settings put global hide_gesture_line 1
