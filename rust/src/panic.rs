/*
 * Author: Dylan Turner
 * Description: Replacement panic function for Rust
 */

use core::panic::PanicInfo;

#[no_mangle]
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
