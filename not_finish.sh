pkg update && pkg upgrade -y
pkg install tur-repo -y
pkg install python-pandas -y
pkg install libsixel -y
pkg install imagemagick -y
pkg install ninja automake cmake binutils patchelf git -y
apt-get install gettext cmake unzip curl -y
pkg install matplotlib -y
git clone https://github.com/neovim/neovim
cd neovim
rm -r build/  # clear the CMake cache
make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
make install
export PATH="$HOME/neovim/bin:$PATH"
cp ~/neovim/bin/nvim /data/data/com.termux/files/usr/bin
pkg install lsd -y
cd && cd .termux && curl -fLo font.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip  && mkdir fonts && mv font.zip fonts &&  cd fonts && unzip font.zip && mv "FiraCodeNerdFont-Regular.ttf" .. && cd .. && mv "FiraCodeNerdFont-Regular.ttf" font.ttf && rm -rf fonts
echo alias ls=lsd >> /data/data/com.termux/files/usr/etc/bash.bashrc
termux-reload-settings
pkg install nodejs -y
pkg install fd ripgrep openssh -y
pkg install tmux -y
pkg install zsh -y
ssh-keygen -t ed25519 -C "chalermpun.mo@gmail.com"
cat ~/.ssh/id_ed25519.pub

cd && mkdir -p .config/ && cd .config
git clone git@github.com:Chalermpun/PDE.git


cd PDE
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp .tmux.conf ~/
git switch lazy
cd .. && cp -r PDE nvim

#close and open
chsh -s zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search

# Update the Zsh configuration file (.zshrc) with the new plugins
sed 's/^plugins=(git/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-fzf-history-search/g' ~/.zshrc >~/zshrc.txt
mv ~/zshrc.txt ~/.zshrc
pip3 install pynvim --upgrade 



sudo apt update
sudo apt-get install -y git fd-find zsh ninja-build gettext cmake unzip curl tmux ripgrep python3 python3-pip python3-venv fontconfig sqlite3 libsqlite3-dev ripgrep libboost-all-dev libicu-dev npm pkg-config -y
curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh -o install_nvm.sh
bash install_nvm.sh
source ~/.bashrc
nvm ls-remote
nvm install v21.3.0
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search

sed 's/^plugins=(git/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-fzf-history-search/g' ~/.zshrc >~/zshrc.txt
mv ~/zshrc.txt ~/.zshrc

git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
make install



 cp -r .ssh/ ubuntu/andronix-fs/home/chale/

mkdir -p ~/.config/nvim
git clone git@github.com:Chalermpun/PDE.git ~/.config/nvim --branch lazy
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cd && wget https://raw.githubusercontent.com/Chalermpun/PDE/master/.tmux.conf
curl https://sh.rustup.rs -sSf | sh -s -- -y
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >>~/.zshrc
source "$HOME/.cargo/env"
cargo install lsd

echo alias ls='lsd' >>~/.zshrc
mkdir ~/.local/share/fonts
cd && cd .local/share/fonts
curl -fLo font.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
unzip font.zip
fc-cache -fv
tmux -u
pip3 install pynvim --upgrade 
