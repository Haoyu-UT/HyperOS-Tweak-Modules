#!/system/bin/sh
# Re-create the override on every boot, as early as the overlay service answers, so keyboards
# shown during boot already sit flush.

MODDIR=${0%/*}
. "$MODDIR/common.sh"

i=0
until cmd overlay list android >/dev/null 2>&1; do
  i=$((i + 1))
  [ $i -ge 120 ] && exit 1
  sleep 1
done
apply_fix

# Check once more after boot, in case anything cleared shell overlays after the early apply.
until [ "$(getprop sys.boot_completed)" = "1" ]; do sleep 2; done
sleep 5
apply_fix
