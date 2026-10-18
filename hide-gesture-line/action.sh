#!/system/bin/sh
# Action button: show the current state.

echo "global hide_gesture_line = $(settings get global hide_gesture_line)"
echo "global force_fsg_nav_bar = $(settings get global force_fsg_nav_bar)"
echo "secure navigation_mode = $(settings get secure navigation_mode)"
