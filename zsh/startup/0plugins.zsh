autoload -U is-at-least
ZGEN_RESET_ON_CHANGE=(
"${HOME}/.zsh/startup/0plugins.zsh"
"${HOME}/.zsh/startup/0plugins.zshenv"
)
source "${HOME}/.zgen/zgen.zsh"


if ! zgen saved; then
  zgen oh-my-zsh

  # Python
  zgen oh-my-zsh plugins/python
  zgen oh-my-zsh plugins/pip
  zgen load sharat87/pip-app

  # Ruby
  zgen load unixorn/rake-completion.zshplugin

  # Golang
  zgen oh-my-zsh plugins/golang

  # Various Utils
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/rsync
  zgen oh-my-zsh plugins/vagrant

  zgen load zsh-users/zsh-completions src

  # Git
  zgen load unixorn/git-extra-commands
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/github

  # zgen oh-my-zsh plugins/colored-man-pages
  #
  if [ $(uname -a | grep -ci Darwin) = 1 ]; then
    # Load OSX-specific plugins
    zgen oh-my-zsh plugins/osx
  fi

  zgen load chrissicool/zsh-256color

  zgen oh-my-zsh plugins/redis-cli
  zgen oh-my-zsh plugins/rsync
  zgen oh-my-zsh plugins/marked2

  # Node.js / NVM
  zgen load lukechilds/zsh-nvm
  zgen load lukechilds/zsh-better-npm-completion

  # Completion generator
  zgen load RobSis/zsh-completion-generator

  # FZF completion fun
  if (( $+commands[fzf] )); then
    zgen load "rupa/z" z.sh
  fi

  if is-at-least 5.0; then
    # Add Fish-like autosuggestions to your ZSH
    zgen load zsh-users/zsh-autosuggestions

    # Add Fish shell like syntax highlighting for ZSH
    if is-at-least 5.3.2; then
      zgen load zsh-users/zsh-syntax-highlighting
    else
      # Work-around for bug https://github.com/zsh-users/zsh-syntax-highlighting/issues/407
      zgen load zsh-users/zsh-syntax-highlighting '' '0.5.0'
    fi
  fi

  # Save it all to init script
  zgen save
fi

# Fixes paste being slow.
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=( end-of-line vi-end-of-line vi-add-eol )
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=( forward-char vi-forward-char )
# Workaround until it's fixed in zsh-autosuggest:
# https://github.com/zsh-users/zsh-autosuggestions/pull/206
typeset -ar ZSH_AUTOSUGGEST_IGNORE_WIDGETS=(
"${ZSH_AUTOSUGGEST_IGNORE_WIDGETS[@]}"
'zle-*'
)

# EOF
