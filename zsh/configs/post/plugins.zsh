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

function zvm_after_init() {
  # accept the autosuggestion one word at a time
  bindkey "^[[1;5C" forward-word      # ctrl+right
  bindkey "^[[1;5D" backward-word     # ctrl+left

  # up/down filter history by what is already typed
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down

  # reset fzf bindings
  bindkey "^R" fzf-history-widget
  bindkey "^T" fzf-file-widget
  bindkey "^F" fzf-file-widget-all
}

zinit light jeffreytse/zsh-vi-mode

# ---------- turbo-loaded plugins ----------

zinit wait lucid for \
  atload'_zsh_autosuggest_start' \
    zsh-users/zsh-autosuggestions \
  zsh-users/zsh-history-substring-search \
  atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay' \
    zdharma-continuum/fast-syntax-highlighting
