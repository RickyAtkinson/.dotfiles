#!/usr/bin/env bash
#
# Create and manage named tmux sessions.

is_tmux_running=$(pgrep tmux)

if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$({
    find ~/projects/*/ -mindepth 1 -maxdepth 1 -type d
    find ~ -mindepth 1 -maxdepth 1 -type d -name .dotfiles
    find ~/documents -mindepth 1 -maxdepth 1 -type d -name .notes
  } | fzf)
fi

if [[ -z $selected ]]; then
  exit 0
fi

session_name=$(basename "$selected" | tr . _)

if [[ -z $is_tmux_running ]]; then
  tmux new-session -s "$session_name" -c "$selected"
  exit 0
fi

if ! tmux has-session -t "$session_name" 2>/dev/null; then
  tmux new-session -s "$session_name" -c "$selected" -d
fi

tmux switch-client -t "$session_name"
