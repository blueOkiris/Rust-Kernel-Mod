# Rust settings
RUST_FLDR :=			rust
RUST_TARGET :=			x86_64-unknown-linux-gnu
RUST_LIB :=				hello_rust.o

# Kernel module settings
MODULE_NAME :=			hello_world

obj-m :=				$(MODULE_NAME).obj
$(MODULE_NAME)-objs:=	$(src)/c/src/$(MODULE_NAME)_main.o $(RUST_LIB)
EXTRA_CFLAGS :=			$(src)/c/include

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
		cargo +nightly \
			rustc --release --target=$(RUST_TARGET) -- \
			--emit=obj -C relocation-model=static -C code-model=kernel -Z plt=y
	cp $(RUST_FLDR)/target/$(RUST_TARGET)/release/deps/*.o $@
