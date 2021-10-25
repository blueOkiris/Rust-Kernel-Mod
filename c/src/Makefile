# Author: Dylan Turner
# Description:
#   Sub-makefile for building the kernel module from the same dir as C files

MODULE_NAME :=			hello_world

obj-m :=				$(MODULE_NAME).o
$(MODULE_NAME)-objs:=	$(MODULE_NAME)_main.o $(RUST_LIB)
EXTRA_CFLAGS :=			-I$(PWD)/../include

.PHONY : all
all : $(MODULE_NAME).ko

.PHONY : clean
clean :
	$(MAKE) -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean

$(MODULE_NAME).ko : $(RUST_LIB) $(wildcard *.c)
	$(MAKE) -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
