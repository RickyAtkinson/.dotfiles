#!/usr/bin/env bash
#
# Installs the neovim dotfiles

# shellcheck source=../config/scripts/lib/utils.sh
source "$HOME/.dotfiles/config/scripts/lib/utils.sh"

echo_info "Installing neovim configs..."

dot_dir="$HOME/.dotfiles/config/neovim"
config_dir="$HOME/.config/nvim"

# Cleanup to avoid broken links hanging around
rm "$config_dir/init.lua" 2>/dev/null
rm "$config_dir/lua/*/*.lua" 2>/dev/null

[ ! -d "$config_dir/lua/config" ] && mkdir -p "$config_dir/lua/config"
[ ! -d "$config_dir/lua/plugins" ] && mkdir -p "$config_dir/lua/plugins"
[ ! -d "$config_dir/lua/utils" ] && mkdir -p "$config_dir/lua/utils"

for dotfile in \
  "$dot_dir"/init.lua \
  "$dot_dir"/lua/*/*.lua; do
  link_file="$config_dir${dotfile#"$dot_dir"}"
  ln -sf "$dotfile" "$link_file"
done
