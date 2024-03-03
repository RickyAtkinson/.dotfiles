#!/usr/bin/env bash
#
# Installs scripts

# shellcheck source=../config/scripts/lib/utils.sh
source "$HOME/.dotfiles/config/scripts/lib/utils.sh"

echo_info "Installing scripts..."

dotfile_dir="$HOME/.dotfiles/config/scripts"
config_dir="$HOME/.local/scripts"

# Cleanup to avoid broken links hanging around
rm -r "${config_dir:?}/*" 2>/dev/null

for dotfile in "$dotfile_dir"/*.sh; do
  link_file="$config_dir${dotfile#"$dotfile_dir"}"
  link_file="${link_file%".sh"}"
  ln -sf "$dotfile" "$link_file"
done
