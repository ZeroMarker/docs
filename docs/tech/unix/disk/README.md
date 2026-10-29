# Disk

磁盘、文件系统和目录占用分析工具。

## ncdu — 交互式磁盘占用分析

```sh
sudo apt install ncdu

ncdu

ncdu --exclude ~/pik
```

### 快照比较

```sh
ncdu -o ~/pik_snapshot.txt   # 导出快照
ncdu -f ~/pik_snapshot.txt   # 读取快照

# C sort by items number
# c toggle items number
```

## 缓存与磁盘清理

```sh
npm cache clean --force

go clean -modcache -cache

apt clean

journalctl --disk-usage

sudo journalctl --vacuum-time=7d

cargo install cargo-cache
cargo cache
cargo cache --autoclean

uv cache prune

sudo rm -rf /var/lib/snapd/cache/*

snap remove gnome-46-2404
snap list

apt list --installed
```

## yazi — 文件管理器

```sh
mise use -g yazi
```
