"""Zip each module folder into out/<folder>-<version>.zip, installable from KernelSU or Magisk.

Usage: python build.py
"""

import pathlib
import zipfile

ROOT = pathlib.Path(__file__).resolve().parent
MODULES = ["keyboard-gap-fix", "hide-gesture-line"]

# Standard Magisk module installer stub: hands off to Magisk's install_module.
# KernelSU ignores it and installs the zip itself.
UPDATE_BINARY = """#!/sbin/sh

umask 022

ui_print() { echo "$1"; }

require_new_magisk() {
  ui_print "*******************************"
  ui_print " Please install Magisk v20.4+! "
  ui_print "*******************************"
  exit 1
}

OUTFD=$2
ZIPFILE=$3

mount /data 2>/dev/null

[ -f /data/adb/magisk/util_functions.sh ] || require_new_magisk
. /data/adb/magisk/util_functions.sh
[ $MAGISK_VER_CODE -lt 20400 ] && require_new_magisk

install_module
exit 0
"""


def prop(path, key):
    for line in path.read_text().splitlines():
        if line.startswith(key + "="):
            return line.split("=", 1)[1]
    raise SystemExit(f"{path}: no {key}=")


def add(z, name, data, mode=0o644):
    info = zipfile.ZipInfo(name, date_time=(2026, 1, 1, 0, 0, 0))
    info.compress_type = zipfile.ZIP_DEFLATED
    info.external_attr = (0o100000 | mode) << 16
    z.writestr(info, data)


def build(folder):
    src = ROOT / folder
    out = ROOT / "out" / f"{folder}-{prop(src / 'module.prop', 'version')}.zip"
    out.parent.mkdir(exist_ok=True)
    with zipfile.ZipFile(out, "w") as z:
        add(z, "META-INF/com/google/android/update-binary", UPDATE_BINARY, 0o755)
        add(z, "META-INF/com/google/android/updater-script", "#MAGISK\n")
        for f in sorted(src.rglob("*")):
            if f.is_file():
                data = f.read_bytes()
                if b"\r\n" in data:
                    raise SystemExit(f"{f}: CRLF line endings break the scripts on Android")
                add(z, f.relative_to(src).as_posix(), data, 0o755 if f.suffix == ".sh" else 0o644)
    print(out.relative_to(ROOT))


if __name__ == "__main__":
    for m in MODULES:
        build(m)
