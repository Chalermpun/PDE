#!/bin/bash

sudo apt-get update
sudo apt-get install -y git zsh ninja-build gettext cmake unzip curl tmux ripgrep python3-venv fontconfig
current_directory=$(pwd)

echo "Zsh and plugins are installing"

# Set Zsh as the default shell
chsh -s $(which zsh)


# Install Oh My Zsh (https://ohmyz.sh/)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

# Update the Zsh configuration file (.zshrc) with the new plugins
sed 's/^plugins=(git/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting/g' ~/.zshrc > ~/zshrc.txt
mv ~/zshrc.txt ~/.zshrc

# Print success message
echo "Zsh and plugins installed successfully. Please restart your terminal."

echo "neovim is installing."
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
make install
echo "neovim finish installed"

mkdir -p ~/.config/nvim
cp "${current_directory}/init.lua" ~/.config/nvim
cp -r "${current_directory}/lua" ~/.config/nvim

echo "installing tmux tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp "${current_directory}/.tmux.conf" ~/


curl https://sh.rustup.rs -sSf | sh -s -- -y
echo "install lsd"
cargo install lsd

echo alias ls='lsd' >> ~/.zshrc


declare -a fonts=(
    AnonymousPro
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
