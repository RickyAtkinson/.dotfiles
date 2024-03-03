#!/usr/bin/env bash
#
# Installs the bash & zsh dotfiles

# shellcheck source=../config/scripts/lib/utils.sh
source "$HOME/.dotfiles/config/scripts/lib/utils.sh"

echo_info "Installing bash and zsh configs..."

dot_dir="$HOME/.dotfiles/config/shell"
config_dir="$HOME/.config"

[ ! -d "$config_dir/shell" ] && mkdir -p "$config_dir/shell"
[ ! -d "$config_dir/zsh" ] && mkdir -p "$config_dir/zsh"

ln -sf "$dot_dir/.aliases" "$config_dir/shell/.aliases"
ln -sf "$dot_dir/.profile" "$HOME/.profile"
ln -sf "$dot_dir/bash/.bashrc" "$HOME/.bashrc"
ln -sf "$dot_dir/bash/.bash_profile" "$HOME/.bash_profile"
ln -sf "$dot_dir/bash/.bash_logout" "$HOME/.bash_logout"
ln -sf "$dot_dir/zsh/.zshenv" "$HOME/.zshenv"
ln -sf "$dot_dir/zsh/.zshrc" "$config_dir/zsh/.zshrc"
ln -sf "$dot_dir/zsh/.zshlogout" "$config_dir/zsh/.zshlogout"
ln -sf "$dot_dir/zsh/prompt_setup" "$config_dir/zsh/prompt_setup"
