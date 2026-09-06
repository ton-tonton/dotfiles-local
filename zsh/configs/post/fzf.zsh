command -v fd > /dev/null || return

# ctrl-t: hidden files included, .gitignore respected.
export FZF_CTRL_T_COMMAND='fd --type f --hidden --follow --exclude .git'

# ctrl-f: the same list plus ignored files (node_modules, build output, ...).
fzf-file-widget-all() {
  local all="$FZF_CTRL_T_COMMAND --no-ignore"
  local FZF_CTRL_T_COMMAND="$all"
  fzf-file-widget
}
zle -N fzf-file-widget-all
