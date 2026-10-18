#!/system/bin/sh
# Runs inside the KernelSU / Magisk installer; MODPATH, ui_print and abort come from it.
# Writing this setting is safe while the system runs: SystemUI just hides the line, and no app
# gets a configuration change.

KEY=hide_gesture_line

cur=$(settings get global $KEY 2>/dev/null)
case "$cur" in
  1) ui_print "- Gesture line already hidden" ;;
  0|null)
    settings put global $KEY 1 && ui_print "- Gesture line hidden" \
      || ui_print "- Could not write the setting now; it will be applied on next boot" ;;
  *) ui_print "- Settings not reachable here; the line will be hidden on next boot" ;;
esac
ui_print "- To undo: disable or remove the module and reboot"
