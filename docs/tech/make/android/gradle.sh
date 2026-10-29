#!/usr/bin/env bash
set -euo pipefail

# 在包含 build.gradle 文件的目录下执行
./gradlew build        # 编译并打包
./gradlew assembleDebug # 只构建 debug 版本的 APK
./gradlew installDebug  # 构建并安装到连接的设备上
