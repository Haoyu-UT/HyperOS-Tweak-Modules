**English** | [简体中文](README.zh-CN.md)

# HyperOS Tweak Modules

Small KernelSU / Magisk modules for HyperOS 3. They are independent: install either one or both. Download
the zips from [Releases](https://github.com/haoyu-UT/HyperOS-Tweak-Modules/releases).

> Not affiliated with Xiaomi.

## Prerequisites

- A rooted phone on HyperOS 3 (Android 16). Tested with KernelSU on a POCO F8 Ultra (`25102PCBEG`,
  OS3.0.301.0.WPMMIXM); Magisk is untested.
- keyboard-gap-fix needs Android 12 or newer.

## keyboard-gap-fix

Removes the gap under the keyboard, along with its two extra keys: "hide keyboard" and "switch keyboard".
Disable or remove the module and reboot to undo it; nothing is left behind.

## hide-gesture-line

Hides the gesture line, the white bar at the bottom of the screen. Gestures keep working.
Disable or remove the module and reboot to undo it; nothing is left behind.

## Building

`python build.py` writes both zips to `out/`.

## License

[MIT](LICENSE). POCO, HyperOS and MIUI are trademarks of Xiaomi. Use at your own risk.
