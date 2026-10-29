# System

系统信息、运行环境和系统配置笔记。

## 系统信息

```sh
# 系统信息
uname -a

# 内核版本
uname -r

neofetch

# 资源占用
top
htop
```

### Windows 版本（WSL 场景）

```sh
neofetch
dmidecode
duf
ifconfig
uname -a
```

## mise — 运行时管理

```sh
# mise en place

mise use -g xh
# xh, curl
# fzf, cd
# yazi, cd
# tldr, man
# fd, find
# lazygit, git
# btop, top
```

## Swap 配置

### 概述

Swap（交换空间）是磁盘上的一块区域，当物理内存（RAM）不足时，系统会将部分内存数据转移到 Swap 中，防止因内存耗尽导致系统崩溃或 OOM Killer 杀死进程。

### 当前配置

- **Swap 大小**: 2GB
- **类型**: 文件形式（/swapfile）
- **Swappiness**: 10（仅在内存紧张时使用）

### 配置时间

2026-06-19，因服务器 OOM 导致崩溃后配置。

### 配置命令

创建 2GB Swap 文件:

```sh
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

持久化（写入 fstab）:

```sh
echo /swapfile none swap sw 0 0 | sudo tee -a /etc/fstab
```

设置 swappiness:

```sh
echo vm.swappiness=10 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

### 常用命令

```sh
sudo swapon --show     # 查看 Swap 状态
free -h

sudo swapoff /swapfile     # 临时关闭
sudo swapon /swapfile      # 重新启用

cat /proc/swaps     # 查看 Swap 使用详情
```

### Swappiness 说明

| 值 | 含义 |
|------|------|
| 0 | 尽量不使用 Swap |
| 10 | 内存紧张时使用（当前配置） |
| 60 | 默认值，平衡使用 |
| 100 | 积极使用 Swap |

### 注意事项

- Swap 文件位于 /swapfile，权限 600
- 已添加到 /etc/fstab，重启后自动启用
- 建议物理内存不足时考虑升级 ECS 规格
