#!/bin/bash

## Download Binary ##
# curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
# sudo rm -rf /opt/nvim
# sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
# rm nvim-linux-x86_64.tar.gz
#
# echo '# NVIM' >> ~/.bashrc
# echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.bashrc
# echo '# NVIM' >> ~/.bashrc

cd /opt || exit 1
git clone https://github.com/neovim/neovim
cd neovim || exit 1
make CMAKE_BUILD_TYPE=Release
sudo make install

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install ripgrep

dnf copr enable tkbcopr/fd
dnf install fd
