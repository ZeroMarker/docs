# Network

网络连接、传输、代理、证书和远程访问相关命令。

## 网络基础命令

```sh
netstat -lntu

nc ip port

nmap ip

sqlmap -u baidu.com

lsof -i :5000

vi /etc/hosts

wget https://go.dev/dl/go1.23.6.linux-amd64.tar.gz
```

## Clash 代理

```sh
git clone https://gh-proxy.com/https://github.com/nelvko/clash-for-linux-install.git \
  && cd clash-for-linux-install \
  && sudo bash -c '. install.sh; exec bash'

clashon

clashoff

clashui
```

## curl

```sh
curl -L https://baidu.com   # 允许重定向

curl ip.sb                  # 本机 IP
curl ipinfo.io

# [Everything about cURL](https://everything.curl.dev/)
```

## rclone

```sh
rclone config

rclone lsf 'pik:My TikTok'

rclone copy this.mp4 'pik:My TikTok' --progress

# 大文件高速上传
rclone copy /path/to/bigvideo.mp4 pik:My\ TikTok \
  --progress \
  --transfers 4 \             # 同时传 4 个文件（调高到 6-8 如果服务器带宽好）
  --multi-thread-streams 4 \  # 每个文件用 4 线程分片
  --pikpak-chunk-size 100M    # 分片大小 100MB（默认 5MiB，太小慢）

# 单行挂载（旧命令）
rclone mount pik: ~/pik --vfs-cache-mode full --vfs-cache-max-size 10G --vfs-read-chunk-size 64M --vfs-read-chunk-size-limit off --vfs-read-ahead 256M --buffer-size 128M --dir-cache-time 24h --poll-interval 1m --allow-other --daemon --log-file ~/rclone_pikpak.log --log-level INFO

fusermount -u ~/pik
```

挂载脚本（推荐）见 [scripts/rclone/mount.sh](../scripts/rclone/mount.sh)。

### 缓存

```sh
du -sh ~/.cache/rclone
```

## 临时服务

```sh
python3 -m http.server
```

## SSH

```sh
ssh user@host
```

### SSH 配置

```sh
ssh-keygen -t rsa -b 4096

# id_rsa.pub
# id_ed25519

vi ~/.ssh/authorized_keys
```

## SSL 证书

### acme.sh

```sh
acme.sh
```

### Cloudflare 端口

Cloudflare 支持的 HTTP 端口：

```
80
8080
8880
2052
2082
2086
2095
```

Cloudflare 支持的 HTTPS 端口：

```
443
2053
2083
2087
2096
8443
```

### ZeroSSL

```sh
zerossl.com

# 90 days
# cname dns verify
# download cert.file
```

### alist

```sh
# apache cert
/opt/alist/data/config.json

data/certificate.crt
data/private.key
force_https
```
