#!/usr/bin/env bash
#
# Installs the tmux dotfiles

# shellcheck source=../config/scripts/lib/utils.sh
source "$HOME/.dotfiles/config/scripts/lib/utils.sh"

echo_info "Installing tmux configs..."

dot_dir="$HOME/.dotfiles/config/tmux"
config_dir="$HOME/.config/tmux"

[ ! -d "$config_dir" ] && mkdir -p "$config_dir"

ln -sf "$dot_dir/tmux.conf" "$config_dir/tmux.conf"
