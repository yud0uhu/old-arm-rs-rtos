#![no_main]
#![no_std]

extern crate panic_halt;

use core::fmt::Write;

use cortex_m_rt::entry;
use cortex_m_semihosting::{debug, hio};

#[entry]
fn main() -> ! {
    let mut stdout = hio::hstdout().unwrap();
    writeln!(stdout, "Hello, world!").unwrap();

    // QEMUもしくはデバッガセッションを終了します
    debug::exit(debug::EXIT_SUCCESS);

    loop {}
}
