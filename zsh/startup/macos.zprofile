if [[ "${OSTYPE}" == darwin* ]]; then
  if [ -x /usr/local/bin/zsh ]; then
    export SHELL=/usr/local/bin/zsh
  fi

  export TERMINAL_NOTIFIER_BIN=$HOME/.local/bin/terminal-notifier
fi
