#!/usr/bin/env bash
#
# Searchs cheat.sh and displays the results in less

pgrep_tmux_output=$(pgrep tmux)

selected=$(cat ~/.dotfiles/config/scripts/lib/cht-sh-languages ~/.dotfiles/config/scripts/lib/cht-sh-commands | fzf)

if [[ -z $selected ]]; then
  exit 0
fi

read -rp "Query: " query
query=$(echo "$query" | tr " " "+")

if [[ -z $pgrep_tmux_output ]]; then
  cmd_prefix="curl --silent cht.sh/"
  cmd_suffix=" | less -RF"
else
  cmd_prefix="tmux neww bash -c \"curl --silent cht.sh/"
  cmd_suffix=" | less -R\""
fi

if grep -qs "$selected" ~/.local/scripts/lib/cht-sh-languages; then
  eval "${cmd_prefix}${selected}/${query}${cmd_suffix}"
else
  eval "${cmd_prefix}${selected}~${query}${cmd_suffix}"
fi
