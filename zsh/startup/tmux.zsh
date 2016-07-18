if [ -n "$TMUX" ]; then

  ssh() {
    local old_allow_rename="$(tmux showw -g automatic-rename | cut -d ' ' -f 2)"
    local old_automatic_rename="$(tmux showw -g automatic-rename | cut -d ' ' -f 2)"
    local old_name="$(tmux display-message -p '#{window_name}')"
    tmux setw automatic-rename off 1>/dev/null
    tmux setw allow-rename off 1>/dev/null
    tmux rename-window "ssh/$*"
    command ssh "$@"
    tmux setw allow-rename "${old_allow_rename}" 1>/dev/null
    tmux setw automatic-rename "${old_automatic_rename}" 1>/dev/null
    tmux rename-window "${old_name}"
  }
fi
