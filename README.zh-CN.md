[English](README.md) | **简体中文**

# HyperOS Tweak Modules

适用于 HyperOS 3 的小型 KernelSU / Magisk 模块。各模块互相独立，可以只装一个，也可以都装。模块 zip 请从
[Releases](https://github.com/haoyu-UT/HyperOS-Tweak-Modules/releases) 下载。

> 本项目与小米公司无关。

## 前提条件

- 已 root、运行 HyperOS 3（Android 16）的手机。已在 POCO F8 Ultra（`25102PCBEG`，OS3.0.301.0.WPMMIXM）上用
  KernelSU 测试；Magisk 未测试。
- keyboard-gap-fix 需要 Android 12 或更高版本。

## keyboard-gap-fix

去掉键盘下方的间隙，和两个按键：“关闭输入法”和“切换输入法”。
停用或移除模块并重启即可撤销，不会留下任何残留。

## hide-gesture-line

隐藏手势提示线（屏幕底部的白条）。全面屏手势照常可用。
停用或移除模块并重启即可撤销，不会留下任何残留。

## 构建

`python build.py` 会把两个 zip 写入 `out/`。

## 许可证

[MIT](LICENSE)。POCO、HyperOS 和 MIUI 是小米的商标。使用风险自负。
