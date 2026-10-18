#!/system/bin/sh
# Shared by service.sh and action.sh.
#
# HyperOS's gesture overlay (com.android.systemui.gesture.line.overlay) sets the framework's
# config_imeDrawsImeNavBar=true, which makes every keyboard draw its own navigation-bar row and
# reserve space for it: the arrow row and the gap. A fabricated overlay owned by the shell
# overrides just that one resource back to false, leaving gesture mode itself alone. The system
# deletes shell fabricated overlays at boot, so this has to be re-created on every boot, and
# undoing it is simply not re-creating it.

NAME=ImeNavBarFix
OVERLAY=com.android.shell:$NAME
RES=android:bool/config_imeDrawsImeNavBar

overlay_state() { cmd overlay list android 2>/dev/null | grep -F "$OVERLAY" | cut -c1-3; }

apply_fix() {
  [ -n "$(overlay_state)" ] || cmd overlay fabricate --target android --name $NAME $RES 0x12 0x0 >/dev/null 2>&1
  [ "$(overlay_state)" = "[x]" ] || cmd overlay enable --user 0 $OVERLAY >/dev/null 2>&1
  [ "$(overlay_state)" = "[x]" ]
}
