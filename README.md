# Rust-Kernel-Mod

## Description

Integration of Rust code with a C Kernel Module

This project sets up a minimalistic Linux kernel module in C which it uses to "bootstrap" Rust code so to speak.

I also include examples of how to link multiple Rust files together while doing this and how to integrate some C kernel functions with the Rust.

## Requirements

 - Linux Kernel Headers
 - Make
 - Gcc
 - Cargo Nightly
   + If you only have stable, use `rustup toolchain install nightly` to install nightly
