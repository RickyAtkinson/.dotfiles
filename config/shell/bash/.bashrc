# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Environment variables
# Added here instead of in `.bash_profile` as certain non-interactive commands
# skip `.profile`, but environment variables would be useful to them.
if [ -f "$HOME/.profile" ]; then
  . "$HOME/.profile"
fi

# Aliases
if [ -f "$HOME/.config/shell/.aliases" ]; then
  . "$HOME/.config/shell/.aliases"
fi

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make `**` match all files and zero or more directories and subdirectories
shopt -s globstar

# Add bash-preexec to emulate zsh preexec and precmd in bash
if [ -f $HOME/.local/share/bash/bash-preexec.sh ]; then
  source $HOME/.local/share/bash/bash-preexec.sh
fi

precmd() {
  # Print a new line before each prompt
  echo ""

  # Use beam shape cursor on load for each new prompt to stop
  # tmux/nvim switching it
  echo -ne "\e[5 q"
}

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Promt
PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]$(echo -e "\n$ ")> "
