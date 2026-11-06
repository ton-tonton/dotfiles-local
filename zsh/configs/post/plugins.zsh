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

# Right arrow: accept one word of the autosuggestion when the cursor is at
# the end of the line; otherwise move one character as usual.
# The leading "_" keeps zsh-autosuggestions from wrapping this widget, so
# POSTDISPLAY (the suggestion text) is still visible here.
function _autosuggest_accept_word_or_forward_char() {
  if [[ -n $POSTDISPLAY && $CURSOR -eq ${#BUFFER} ]]; then
    zle forward-word
  else
    zle vi-forward-char
  fi
}

function zvm_after_init() {
  # right: accept one word; shift+right: accept the whole suggestion
  zle -N _autosuggest_accept_word_or_forward_char
  bindkey "^[[C" _autosuggest_accept_word_or_forward_char    # right
  bindkey "^[OC" _autosuggest_accept_word_or_forward_char    # right (app mode)
  bindkey "^[[1;2C" autosuggest-accept                       # shift+right

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
