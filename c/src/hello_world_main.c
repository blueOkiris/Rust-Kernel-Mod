/*
 * Author: Dylan Turner
 * Description: Kernel Module entry point for "Hello, world!" kernel module
 */

#include <linux/module.h>
#include <linux/init.h>

#include "hello_rust.h"

MODULE_AUTHOR("Dylan Turner");
MODULE_DESCRIPTION("Hello World From Rust");

// On module insertion
static int __init rust_loader_init(void) {
    pr_info("Loading code from Rust library!\n");
    hello_from_rust();
    return 0;
}

// On module removal
static void __exit rust_loader_cleanup(void) {
    pr_info("Cleaning up Rust library code!\n");
}

module_init(rust_loader_init);
module_exit(rust_loader_cleanup);
