#!/system/bin/sh
# Action button: show the state, and apply the override now if it isn't active.

MODDIR=${0%/*}
. "$MODDIR/common.sh"

echo "config_imeDrawsImeNavBar = $(cmd overlay lookup android $RES 2>/dev/null | tail -n 1)"
if [ "$(overlay_state)" = "[x]" ]; then
  echo "Override active."
  exit 0
fi

# Applying sends a configuration change to every app, this manager included. Do it from a
# detached job a moment after this script exits, so the manager has finished showing the output.
echo "Override not active; applying in 2 s. Open apps, this one included, will redraw."
setsid sh -c ". '$MODDIR/common.sh'; sleep 2; apply_fix" </dev/null >/dev/null 2>&1 &
