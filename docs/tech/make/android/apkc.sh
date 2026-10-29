#!/usr/bin/env bash
set -euo pipefail

apkc create myapp   # 创建一个新项目
cd myapp
apkc build          # 构建 APK
apkc run            # 在设备上运行并查看日志
