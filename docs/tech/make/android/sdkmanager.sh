#!/usr/bin/env bash
set -euo pipefail

# 查看所有可用的包
sdkmanager --list

# 安装核心组件（以 API 33 为例）
sdkmanager "platform-tools"                  # Android 调试桥 (adb)
sdkmanager "build-tools;33.0.2"              # 构建工具 (aapt2, d8等)
sdkmanager "platforms;android-33"            # API 33 的平台文件 (android.jar)
sdkmanager "sources;android-33"              # Android SDK 源码
sdkmanager "emulator"                        # 官方模拟器 (可选)

# 接受所有许可协议
yes | sdkmanager --licenses
