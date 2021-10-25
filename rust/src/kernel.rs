/*
 * Author: Dylan Turner
 * Description: Rust bindings for C kernel functions
 */

extern "C" {
    pub fn printk(string : *const u8, ...) -> u64;
}
