# Zsh plugins, managed by zinit.

ZINIT_ZSH="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/zinit/zinit.zsh"
[[ -r $ZINIT_ZSH ]] || return
source "$ZINIT_ZSH"

# ---------- vi mode ----------

function zvm_config() {
  ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
  ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
  ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
  ZVM_VI_EDITOR='nvim'
}

# Accept one suggestion word at end of line, else move one char.
function accept-word-or-forward-char() {
  local typed_length=$(( ${#BUFFER} - ${#POSTDISPLAY} ))
  if [[ -n $POSTDISPLAY && $CURSOR -eq $typed_length ]]; then
    zle .forward-word
  else
    zle .vi-forward-char
  fi
}

function zvm_after_init() {
  zle -N accept-word-or-forward-char
  bindkey "^[[C" accept-word-or-forward-char    # right
  bindkey "^[OC" accept-word-or-forward-char    # right

  bindkey "^[[1;5D" backward-word     # ctrl+left

  # reset fzf bindings
  bindkey "^R" fzf-history-widget
  bindkey "^T" fzf-file-widget
  bindkey "^F" fzf-file-widget-all
}

zinit light jeffreytse/zsh-vi-mode

# ---------- turbo-loaded plugins ----------

# Keep this order: highlighting, history search, autosuggestions.
# up/down: search history; shift+right: accept whole suggestion.
zinit wait lucid for \
  atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay' \
    zdharma-continuum/fast-syntax-highlighting \
  atload'
    bindkey "^[[A" history-substring-search-up
    bindkey "^[[B" history-substring-search-down' \
    zsh-users/zsh-history-substring-search \
  atload'
    ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(accept-word-or-forward-char)
    _zsh_autosuggest_start
    bindkey "^[[1;2C" autosuggest-accept' \
    zsh-users/zsh-autosuggestions
