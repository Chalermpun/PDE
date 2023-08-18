#!/bin/bash

apt-get update
apt-get install -y git zsh ninja-build gettext cmake unzip curl tmux ripgrep python3 python3-pip python3-venv fontconfig sqlite3 libsqlite3-dev ripgrep libboost-all-dev libicu-dev npm pkg-config
current_directory=$(pwd)

# Set Zsh as the default shell
chsh -s $(which zsh)


# Install Oh My Zsh (https://ohmyz.sh/)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search

# Update the Zsh configuration file (.zshrc) with the new plugins
sed 's/^plugins=(git/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-fzf-history-search/g' ~/.zshrc > ~/zshrc.txt
mv ~/zshrc.txt ~/.zshrc


git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
make install

mkdir -p ~/.config/nvim
cp "${current_directory}/init.lua" ~/.config/nvim
cp -r "${current_directory}/lua" ~/.config/nvim

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp "${current_directory}/.tmux.conf" ~/


curl https://sh.rustup.rs -sSf | sh -s -- -y
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.zshrc
source "$HOME/.cargo/env"
cargo install lsd

echo alias ls='lsd' >> ~/.zshrc


declare -a fonts=(
    JetBrainsMono
)

version='3.0.2'
fonts_dir="${HOME}/.local/share/fonts"

if [[ ! -d "$fonts_dir" ]]; then
    mkdir -p "$fonts_dir"
fi

for font in "${fonts[@]}"; do
    zip_file="${font}.zip"
    download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"
    echo "Downloading $download_url"
    wget "$download_url"
    unzip "$zip_file" -d "$fonts_dir"
    rm "$zip_file"
done

find "$fonts_dir" -name '*Windows Compatible*' -delete

fc-cache -fv

pip install notebook nbclassic jupyter-console jupynium visidata pynvim
cargo install viu
cargo install tokei
cargo install bottom --locked
cargo install navi
cargo install so
cargo install fd-find
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
rm -rf Dockerfile README.md init.lua lazy-lock.json lua neovim setup.sh

# don't forget setting system-site-package for jedi-language-server-protocal (lsp-config)
