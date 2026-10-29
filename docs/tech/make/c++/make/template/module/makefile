# 编译器和编译选项
CC = gcc
CFLAGS = -Wall -g
LDFLAGS = -lmylib

# 目标文件
TARGET = my_program

# 源文件和对象文件
SRCDIR = src
OBJDIR = obj
SRCS = $(wildcard $(SRCDIR)/*.c)
OBJS = $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(SRCS))

# 默认目标
all: $(TARGET)

# 链接目标文件生成可执行文件
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS) $(LDFLAGS)

# 生成每个源文件的对象文件
$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

# 创建目标目录
$(OBJDIR):
	mkdir -p $(OBJDIR)

# 清理生成的文件
clean:
	rm -rf $(OBJDIR) $(TARGET)

# 伪目标
.PHONY: all clean
