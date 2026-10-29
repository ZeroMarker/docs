CC ?= gcc
CFLAGS ?= -Wall -Wextra -std=c99 -O2
TARGET := main
OBJS := main.o max.o min.o

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean: 
	rm -f $(OBJS) $(TARGET)

.PHONY: all clean

# target: dependency
# 	command

# make hello
# cc hello.c -o hello
