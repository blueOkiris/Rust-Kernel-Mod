# Rust-Kernel-Mod

## Description

Integration of Rust code with a C Kernel Module

This project sets up a minimalistic Linux kernel module in C which it uses to "bootstrap" Rust code so to speak.

I also include examples of how to link multiple Rust files together while doing this and how to integrate some C kernel functions with the Rust.

## Building the Module

Just run `make`.

NOTE: You __must__ use a path with no spaces when building Linux kernel modules, including this one!

## Requirements

 - Linux Kernel Headers
 - Make
 - Gcc
 - Cargo Nightly
   + If you only have stable, use `rustup toolchain install nightly` to install nightly
   + Simply installing nightly will not set it as default, don't worry
