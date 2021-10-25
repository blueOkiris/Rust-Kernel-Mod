/*
 * Author: Dylan Turner
 * Description: Rust library entry point for "Hello, world!" module
 */

#![no_std]
#![feature(c_variadic)]

mod panic;
mod kernel;

#[no_mangle]
pub extern "C" fn hello_from_rust() {
    unsafe { kernel::printk("'Hello, world!' from Rust!\n".as_ptr()) };
}
