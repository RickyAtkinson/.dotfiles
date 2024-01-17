#!/usr/bin/env bash
#
# Automate setting up an Ubuntu WSL environment

source ./config/scripts/lib/utils.sh

working_dir=$(pwd)

# Get the version number for the latest release of a github repo given
get_latest_github_release_number() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" |
    grep '"tag_name":' |         # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/' # Pluck JSON value
}

# Checking that code is installed
if [[ ! $(command -v "code") ]]; then
  echo_error "VS Code needs to be installed. Exiting."
  exit 65 # Error 65: Package not installed
fi

# Grab info before update then setup git after software install
echo_info "Gathering required data..."
continue=true
while $continue; do
  read -p "Enter you git user.name: " git_name
  read -p "Enter you git user.email: " git_email

  echo -e "\ngit name: $git_name"
  echo -e "git email: $git_email\n"

  read -p "Is that correct? (y/N): " git_confirm

  git_confirm=$(echo "$git_confirm" | tr "[:upper:]" "[:lower:]")
  if [ "$git_confirm" = "y" ] || [ "$git_confirm" = "yes" ]; then
    continue=false
  fi
done

echo_info "Starting update\upgrade..."
sudo apt update && sudo apt upgrade -y

echo_info "Creating directories..."
mkdir -p ~/desktop
mkdir -p ~/downloads
mkdir -p ~/templates
mkdir -p ~/public
mkdir -p ~/documents
mkdir -p ~/music
mkdir -p ~/pictures
mkdir -p ~/videos
mkdir -p ~/projects
mkdir -p ~/projects/personal
mkdir -p ~/projects/sandbox
mkdir -p ~/projects/tools
mkdir -p ~/projects/tutorials
mkdir -p ~/projects/work
mkdir -p ~/projects/library
mkdir -p ~/.local/share/bash # Needed so curl download doesn't fail
mkdir -p ~/.cache/zsh        # Needed so zsh can create history file

echo_info "Mounting .ssh folder..."
mkdir -m 700 ~/.ssh
# Get Windows user name for file path
cd /mnt/c/ # Switch to Windows drive to avoid errors
win_user=$(cmd.exe /c "echo %USERNAME%" | tr -d "\r")
cd "$working_dir"
# Add a permanent fstab entry for Windows user .ssh directory and mount
cat <<EOF | sudo tee -a /etc/fstab
C:\Users\\$win_user\.ssh\ /home/$USER/.ssh drvfs rw,noatime,uid=$(id -u),gid=$(id -g),case=off,umask=0077,fmask=0177 0 0
EOF
sudo mount /home/$USER/.ssh

# Version of neovim in default repos is too old
echo_info "Adding neovim-ppa/unstable repository..."
sudo apt-add-repository ppa:neovim-ppa/unstable

# Some software is already installed but mark it as "user installed"
echo_info "Installing software..."
sudo apt -y install \
  ansible \
  bat \
  btop \
  build-essential \
  ca-certificates \
  cmatrix \
  cowsay \
  dos2unix \
  fd-find \
  ffmpeg \
  fortune-mod \
  fzf \
  git \
  golang \
  graphicsmagick \
  imagemagick \
  lua5.1 \
  luajit \
  luarocks \
  lynx \
  neofetch \
  neovim \
  pandoc \
  python-is-python3 \
  python3 \
  python3-pip \
  ripgrep \
  tar \
  texlive-full \
  tldr \
  tmux \
  unzip \
  xdg-user-dirs \
  wget \
  zoxide \
  zsh

sudo snap install \
  diff-so-fancy \
  fx

echo_info "Configuring git..."
git config --global user.name "$git_name"
git config --global user.email "$git_email"
git config --global core.autocrlf input
git config --global core.pager "diff-so-fancy | less --tabs=2 -RFXS --pattern '^(Date|added|deleted|modified): '"
git config --global init.defaultBranch main
git config --global push.default current

echo_info "Getting git repos..."
curl https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh \
  -o ~/.local/share/bash/bash-preexec.sh
git clone https://github.com/zsh-users/zsh-completions.git \
  ~/.local/share/zsh/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ~/.local/share/zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ~/.local/share/zsh/plugins/zsh-syntax-highlighting
git clone git@github.com:RickyAtkinson/.notes.git ~/documents/.notes
git clone git@github.com:pipeseroni/pipes.sh.git ~/projects/library/pipes.sh

echo_info "Installing Volta Node version manager..."
curl https://get.volta.sh | bash
# Setup env variables needed by volta so we don't have to open a new shell
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export VOLTA_FEATURE_PNPM=1 # Needed to support pnpm

echo_info "Installing Node and package managers..."
volta install node
volta install yarn
volta install pnpm

echo_info "Installing global node packages..."
npm install -g degit tree-sitter-cli

echo_info "Installing pyvim for Neovim Python support..."
python3 -m pip install --user --upgrade pynvim

echo_info "Installing gopls..."
go install -v golang.org/x/tools/gopls@latest

echo_info "Installing VS Code extensions..."
while IFS="" read -r extension; do
  code --install-extension "$extension"
done <./setup-scripts/lib/vscode-extensions

echo_info "Installing dotfiles..."
./setup-scripts/xdg-user-dirs.sh
./setup-scripts/scripts.sh
./setup-scripts/shell.sh
./setup-scripts/tmux.sh
./setup-scripts/neovim.sh

echo_info "Installing third part source code..."
echo_info "Installing pipes.sh..."
cd ~/projects/library/pipes.sh
make PREFIX=$HOME/.local/ install
cd $working_dir

echo_info "Downloading Eisvogel latex theme..."
eisvogel_version=$(get_latest_github_release_number "Wandmalfarbe/pandoc-latex-template")
eisvogel_folder_name="Eisvogel-$eisvogel_version"
wget https://github.com/Wandmalfarbe/pandoc-latex-template/releases/download/$eisvogel_version/$eisvogel_folder_name.tar.gz \
  -O ~/downloads/$eisvogel_folder_name.tar.gz
mkdir ~/downloads/$eisvogel_folder_name
tar -xzf ~/downloads/$eisvogel_folder_name.tar.gz -C ~/downloads/$eisvogel_folder_name
sudo mv ~/downloads/$eisvogel_folder_name/eisvogel.latex /usr/share/pandoc/data/templates/eisvogel.latex
rm -r ~/downloads/$eisvogel_folder_name ~/downloads/$eisvogel_folder_name.tar.gz

echo_info "Setting default shell to zsh..."
chsh -s $(which zsh)

echo_success "WSL setup is complete! Reload your terminal to complete."
