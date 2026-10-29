# .DEFAULT_GOAL := generate
# default target is the first target

CC ?= gcc
# make CC=clang

all: say_hello generate

say_hello:
	@echo "Hello World!"

generate:
	@echo "Creating files"
	touch file-1.txt file-2.txt file-3.txt file-4.txt file-5.txt

list:
	@echo "Listing files"
	ls

clean:
	rm -f file-*.txt

.PHONY: all say_hello generate list clean
