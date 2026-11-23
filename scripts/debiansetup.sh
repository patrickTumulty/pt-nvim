#!/bin/bash
set -euo pipefail

TARGET_NVIM_VERSION=v0.12.6

pushd ~
wget "https://github.com/neovim/neovim/releases/download/${TARGET_NVIM_VERSION}/nvim-linux-x86_64.tar.gz"
tar -xf nvim-linux-x86_64.tar.gz
rm -f nvim-linux-x86_64.tar.gz
sudo ln -sf "$HOME/nvim-linux-x86_64/bin/nvim" /usr/local/bin/nvim
popd

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

sudo apt update
sudo apt install -y clang build-essential

cargo install ripgrep tree-sitter-cli fd-find

