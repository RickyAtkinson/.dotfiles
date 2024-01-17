# .zshenv

if [ -f $HOME/.profile ]; then
  source $HOME/.profile
fi

# History filepath
export HISTFILE="$XDG_CACHE_HOME/zsh/history"
# Maximum events for internal history
export HISTSIZE=10000
# Maximum events in history file
export SAVEHIST=10000

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
