sudo apt-get update && apt-get install sudo -y
sudo apt-get install git fd-find zsh bat tree ninja-build gettext cmake unzip curl tmux ripgrep python3 python3-pip python3-venv python3-dev python3-setuptools fontconfig sqlite3 libsqlite3-dev ripgrep libboost-all-dev libicu-dev npm pkg-config -y
curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh -o install_nvm.sh
git clone https://github.com/neovim/neovim && cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
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
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
mkdir -p ~/.config
echo 'alias tmux="tmux -u"' >>~/.zshrc
mkdir ~/.local/share/fonts
cd && cd .local/share/fonts
curl -fLo font.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
unzip font.zip
fc-cache -fv
pip3 install pynvim --upgrade

echo '
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    nvim)         fzf "$@" --preview 'batcat --style=numbers --color=always {}' ;;
    *)            fzf "$@" ;;
  esac
}
' >> ~/.zshrc

curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
pip3 install thefuck --user

# Install httpie
curl -SsL https://packages.httpie.io/deb/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/httpie.gpg
sudo echo "deb [arch=amd64 signed-by=/usr/share/keyrings/httpie.gpg] https://packages.httpie.io/deb ./" > /etc/apt/sources.list.d/httpie.list
sudo apt update
sudo apt install httpie


