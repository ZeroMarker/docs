# 编译器和编译选项
CC = gcc
CFLAGS = -Wall -g
LDFLAGS =

# 目标文件
TARGET = my_program

# 源文件和对象文件
SRCS = main.c foo.c bar.c
OBJS = $(SRCS:.c=.o)

# 默认目标
all: $(TARGET)

# 链接目标文件生成可执行文件
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS) $(LDFLAGS)

# 生成每个源文件的对象文件
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# 清理生成的文件
clean:
	rm -f $(OBJS) $(TARGET)

# 伪目标
.PHONY: all clean
