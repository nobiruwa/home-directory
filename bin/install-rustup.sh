#!/usr/bin/env bash

# https://rust-lang.github.io/rustup/installation/other.html
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path

if command -v rustup &> /dev/null ; then
   rustup update
fi
