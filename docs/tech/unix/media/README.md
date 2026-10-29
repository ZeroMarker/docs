# Media

媒体文件和桌面应用相关命令。

## 终端浏览器

```sh
apt install w3m
apt install lynx
```

## 字典与翻译

```sh
kd

sudo apt install dict
sudo apt install wordnet
```

## 图片

```sh
apt install catimg
catimg 01.jpg

# https://tinplavec.medium.com/how-to-open-an-image-directly-inside-the-terminal-0c730b2f1f04
# windterm x11 enable

apt install feh
apt install sxiv

apt install terminology
terminology
tyls
tycat

chafa
sixel
```

## PDF

```sh
less name.pdf

apt install poppler-utils
```

## 视频

```sh
asciiplayer
termplay
mpv
```

| 后端 | 效果 | 命令示例 |
| --- | --- | --- |
| tct | 黑白字符画，兼容性最好 | `mpv --vo=tct 视频.mp4` |
| caca | 彩色字符画，需要安装 libcaca | `mpv --vo=caca 视频.mp4` |
| kitty | 真彩色图片，仅限 Kitty 终端 | `mpv --vo=kitty 视频.mp4` |
| sixel | 真彩色图片，需终端支持 Sixel | `mpv --vo=sixel 视频.mp4` |
| null | 无视频，仅音频 | `mpv --vo=null 视频.mp4` |
