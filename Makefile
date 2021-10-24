# Rust settings
RUST_FLDR :=			rust
RUST_TARGET :=			x86_64-unknown-linux-gnu
RUST_LIB :=				hello_rust.o

# Kernel module settings
MODULE_NAME :=			hello_world

obj-m :=				$(MODULE_NAME).o
$(MODULE_NAME)-objs:=	c/$(MODULE_NAME)_main.o $(RUST_LIB)

.PHONY : all
all : $(MODULE_NAME).ko

.PHONY : clean
clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean

	rm -rf $(RUST_LIB)
	rm -rf $(RUST_FLDR)/target

$(MODULE_NAME).ko : $(RUST_LIB) $(MODULE_NAME)_main.c
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

$(RUST_LIB) : $(wildcard $(RUST_FLDR)/src/*.rs) $(RUSTC)
	cd $(RUST_FLDR); \
		cargo rustc --release -- \
			--emit=obj -C relocation-model=static -C code-model=kernel -Z plt=y
	cp $(RUST_FLDR)/target/$(RUST_TARGET)/release/deps/*.o $@
