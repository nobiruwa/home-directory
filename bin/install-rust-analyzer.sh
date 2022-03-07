#!/usr/bin/env bash

# https://rust-analyzer.github.io/manual.html#installation

if command -v rustup &> /dev/null ; then
    rustup component add rust-src
fi

# https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary

mkdir -p ~/.local/bin

curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer

chmod +x ~/.local/bin/rust-analyzer
