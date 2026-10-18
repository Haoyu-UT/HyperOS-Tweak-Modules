#!/system/bin/sh
# Runs inside the KernelSU / Magisk installer; MODPATH, API, ui_print and abort come from it.
# Changes nothing on the running system: enabling an overlay on the framework sends a
# configuration change to every app, the manager doing this install included.

[ "$API" -ge 31 ] || abort "! Needs Android 12 or newer for fabricated overlays (this is API $API)"

val=$(cmd overlay lookup android android:bool/config_imeDrawsImeNavBar 2>/dev/null | tail -n 1)
case "$val" in
  true)  ui_print "- config_imeDrawsImeNavBar is true here: the keyboard gap applies" ;;
  false) ui_print "- config_imeDrawsImeNavBar is already false; this module changes nothing visible" ;;
  *)     abort "! This Android version has no config_imeDrawsImeNavBar; nothing to fix" ;;
esac

ui_print "- Reboot to apply, or use the Action button to apply now (open apps redraw)"
ui_print "- To undo: disable or remove the module and reboot"
