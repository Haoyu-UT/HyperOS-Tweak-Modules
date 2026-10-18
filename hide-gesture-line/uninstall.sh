#!/system/bin/sh
# Runs when the module is removed, normally early in boot (post-fs-data) before settings work.
# The guard (see guard.sh) shows the line again later in that boot; make sure it's there even if
# someone deleted it.

MODDIR=${0%/*}
GUARD=/data/adb/service.d/hyperos_hide_gesture_line_guard.sh

mkdir -p ${GUARD%/*}
cp "$MODDIR/guard.sh" $GUARD && chmod 755 $GUARD

# Some managers run this with the system up; then show the line right away.
[ "$(getprop sys.boot_completed)" = "1" ] && settings put global hide_gesture_line 0 && rm -f $GUARD
