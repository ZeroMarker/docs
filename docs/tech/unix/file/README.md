# File

文件查找、编辑、链接、压缩和回收站相关命令。

## 编辑

```sh
# 创建空文件
: > test.c

# 追加新行
echo "" >> test.c
```

## find — 文件查找

```sh
find . -type f -name *.out -delete

find /usr -type f -name "*.conf"

sudo find / -type f -name "*.swp" -delete
```

## 链接

```sh
echo "This is file1" > file1
ls -li    # --inode
ln file1 file2    # 硬链接
cat file2

ln -s file1 file2    # 软链接
```

## 回收站

```sh
gio trash *.txt    # 移动文件到回收站
ls ~/.local/share/Trash/files
```

## 压缩与解压

```sh
tar cf target.tar file1 file2

tar czf target.tar.gz file1 file2

tar xvf source.tar.gz

tar -cvf test.tar test/ test2/
gzip test.tar
gunzip test.tar.gz
```
