#!/system/bin/sh
# Installed to /data/adb/service.d/ by the hyperos_hide_gesture_line module. Disabling or removing
# a module runs none of its own scripts, so this runs on every boot instead. While the module is
# active it does nothing. Once the module is off, it shows the gesture line again and deletes
# itself. The module reinstalls it if it's turned back on, so the line is shown again only once
# and a later choice in Settings is left alone.

MOD=/data/adb/modules/hyperos_hide_gesture_line

[ -d $MOD ] && [ ! -f $MOD/disable ] && [ ! -f $MOD/remove ] && exit 0

until [ "$(getprop sys.boot_completed)" = "1" ]; do sleep 2; done
settings put global hide_gesture_line 0 && rm -f "$0"
