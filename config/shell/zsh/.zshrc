# .zshrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
if [ -f "$HOME/.config/shell/.aliases" ]; then
  source "$HOME/.config/shell/.aliases"
fi

# Do not write a duplicates to the history file
setopt HIST_SAVE_NO_DUPS
# Do not record an event starting with a space
setopt HIST_IGNORE_SPACE
# Expire a duplicate event first when trimming history
setopt HIST_EXPIRE_DUPS_FIRST
# Do not record an event that was just recorded again
setopt HIST_IGNORE_DUPS
# Delete an old recorded event if a new event is a duplicate
setopt HIST_IGNORE_ALL_DUPS
# Do not display a previously found event
setopt HIST_FIND_NO_DUPS
# Do not execute immediately upon history expansion
setopt HIST_VERIFY

# Enable completions
autoload -U compinit; compinit
zstyle ":completion:*" menu select
# Auto complete with case insenstivity
zstyle ":completion:*" matcher-list "" "m:{a-zA-Z}={A-Za-z}" "r:|[._-]=* r:|=*" "l:|=* r:|=*"
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# Prompt
fpath=($ZDOTDIR $fpath)
autoload -Uz prompt_setup; prompt_setup

# Use beam shape cursor on load for each new prompt
precmd() { echo -ne "\e[5 q"; }

# Make alt+backspace, etc. act like bash
autoload -U select-word-style
select-word-style bash

# Fix backspace not working properly
bindkey "^?" backward-delete-char

# Fix alt+backspace not working properly
bindkey "^[^?" backward-kill-word

# Reset delete, home and end keys to regular behavior
bindkey "^[[7~" beginning-of-line # `home` key
bindkey "^[OH" beginning-of-line # WSL `home` key
bindkey "^[[8~" end-of-line # `end` key
bindkey "^[OF" end-of-line # WSL `end` key
bindkey "^[[3~" delete-char # `del` key

# fzf
if [ -f "/usr/share/doc/fzf/examples/completion.zsh" ]; then
  source "/usr/share/doc/fzf/examples/completion.zsh"
fi
if [ -f "/usr/share/doc/fzf/examples/key-bindings.zsh" ]; then
  source "/usr/share/doc/fzf/examples/key-bindings.zsh"
fi

# Run the tmux sessionizer script
bindkey -s ^f "sessionizer\n"

# Vi mode
bindkey -v
export KEYTIMEOUT=5

# Change cursor shape for different vi modes
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 = "block" ]]; then
    echo -ne "\e[2 q"
  elif [[ ${KEYMAP} == main ]] ||
    [[ ${KEYMAP} == viins ]] ||
    [[ ${KEYMAP} = "" ]] ||
    [[ $1 = "beam" ]]; then
    echo -ne "\e[5 q"
  fi
}
zle -N zle-keymap-select

# Use vim keys in tab complete menu
bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "j" vi-down-line-or-history
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char

# Autocompletion using arrow keys and vim keys in vi mode
bindkey "\e[A" history-search-backward # up arrow
bindkey -M vicmd "j" history-search-backward
bindkey "\e[B" history-search-forward # down arrow
bindkey -M vicmd "k" history-search-forward

# Unbind execute command(`:`) in the command line
bindkey -M vicmd -r ":"

# Reset delete, home and end keys to regular behavior in vi modes too
bindkey -M vicmd "^[[7~" beginning-of-line # `home` key
bindkey -M vicmd "^[OH" beginning-of-line # WSL `home` key
bindkey -M vicmd "^[[8~" end-of-line # `end` key
bindkey -M vicmd "^[OH" end-of-line # WSL `end` key
bindkey -M vicmd "^[[3~" delete-char # `del` key

# Adding text objects to allow commands like `ci"` and `da(`
autoload -Uz select-bracketed select-quoted
zle -N select-bracketed
zle -N select-quoted
for km in viopp visual; do
  bindkey -M $km -- "-" vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-\()\[]{}<>bB}; do
    bindkey -M $km $c select-bracketed
  done
done

# Mimic vim-surrounding behaviour
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd gsr change-surround
bindkey -M vicmd gsd delete-surround
bindkey -M vicmd gsa add-surround

# Plugins
fpath=($HOME/.local/share/zsh/plugins/zsh-completions/src $fpath)
source $HOME/.local/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.local/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
