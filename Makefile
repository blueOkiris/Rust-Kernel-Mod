# Author: Dylan Turner
# Description: Primary Makefile for building rust lib and linking to k mod

# Rust settings
RUST_FLDR :=			rust
RUST_TARGET :=			x86_64-unknown-linux-gnu
RUST_LIB :=				hello_rust.o

# Kernel module settings
MODULE_NAME :=			hello_world
KMOD_FLDR :=			c/src

.PHONY : all
all : $(MODULE_NAME).ko

.PHONY : clean
clean:
	$(MAKE) -C $(KMOD_FLDR) PWD=$(PWD)/$(KMOD_FLDR) clean
	rm -rf $(MODULE_NAME).ko

	rm -rf $(KMOD_FLDR)/$(RUST_LIB)
	rm -rf $(KMOD_FLDR)/.$(RUST_LIB).cmd
	rm -rf $(RUST_FLDR)/target

$(MODULE_NAME).ko : $(KMOD_FLDR)/$(RUST_LIB) $(wildcard $(KMOD_FLDR)/*.c) $(KMOD_FLDR)/.$(RUST_LIB).cmd
	$(MAKE) -C $(KMOD_FLDR) RUST_LIB=$(RUST_LIB) PWD=$(PWD)/$(KMOD_FLDR)
	cp $(KMOD_FLDR)/*.ko .

$(KMOD_FLDR)/.$(RUST_LIB).cmd :
	echo "cmd_$(PWD)/$(RUST_LIB) := cargo" > $@
	echo "source_$(PWD)/$(RUST_LIB) := $(addprefix $(PWD)/,$(wildcard $(RUST_FLDR)/src/*.rs))" >> $@

$(KMOD_FLDR)/$(RUST_LIB) : $(wildcard $(RUST_FLDR)/src/*.rs) $(RUSTC)
	cd $(RUST_FLDR); \
		cargo +nightly \
			rustc --release --target=$(RUST_TARGET) -- \
			--emit=obj -C relocation-model=static -C code-model=kernel -Z plt=y
	cp $(RUST_FLDR)/target/$(RUST_TARGET)/release/deps/*.o $@
