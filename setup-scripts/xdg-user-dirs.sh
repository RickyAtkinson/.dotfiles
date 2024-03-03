#!/usr/bin/env bash
#
# Installs the xdg-user-dirs dotfiles

# shellcheck source=../config/scripts/lib/utils.sh
source "$HOME/.dotfiles/config/scripts/lib/utils.sh"

echo_info "Installing xdg-user-dirs configs..."

dot_dir="$HOME/.dotfiles/config/xdg-user-dirs"
config_dir="$HOME/.config"

[ ! -d "$config_dir" ] && mkdir "$config_dir"

ln -sf "$dot_dir/.user-dirs.dirs" "$config_dir/.user-dirs.dirs"
