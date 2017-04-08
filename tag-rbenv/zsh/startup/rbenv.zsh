if [ "${ZSH_ENABLERUBY}" != false ]; then
  containsElement () {
    local e
    for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
    return 1
  }

  if (( $+commands[rbenv] )) && [ -d "${RBENV_ROOT}" ]; then
    mkdir -p "${RBENV_ROOT}/cache"
    if ! (( $+functions[rbenv] )); then
      eval "$(rbenv init - --no-rehash)"
    fi

    # Only run rbenv rehash if it was run over 5 minutes ago.
    for i in "${RBENV_ROOT}/shims"(/Nmm+5); do
      touch "${RBENV_ROOT}/shims"
      {
        rbenv rehash
      } &!
    done

    function rbenv_rehash { rbenv rehash }
    custom_rehash_hooks=( rbenv_rehash "${custom_rehash_hooks[@]}" )
    alias bi="bundle install --binstubs .bundle/bin"
  fi
else
  alias bi="bundle install"
fi
