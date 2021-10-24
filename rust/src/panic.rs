use core::panic::PanicInfo;

#[no_mangle]
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
