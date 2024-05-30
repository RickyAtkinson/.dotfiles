# .profile

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"

export EDITOR="nvim"
export VISUAL="code"

export GOPATH="$HOME/go"
export VOLTA_HOME="$HOME/.volta"
export VOLTA_FEATURE_PNPM=1

export SHOPIFY_CLI_NO_ANALYTICS=1

export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!{node_modules,.git}'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export PATH="$GOPATH/bin:$VOLTA_HOME/bin:$HOME/.local/scripts${PATH:+:${PATH}}"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private .local/bin if it exists
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes local Ruby gems
if which ruby >/dev/null && which gem >/dev/null; then
  PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi
