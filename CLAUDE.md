## What this repo is

Personal overrides layered on top of [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles) (cloned at `~/dotfiles`). Both are linked into `$HOME` by [rcm](https://github.com/thoughtbot/rcm). Settings come from `~/dotfiles/rcrc`:

- `DOTFILES_DIRS="$HOME/dotfiles-local $HOME/dotfiles"`: this repo wins when the same file exists in both.
- `EXCLUDES="*.md LICENSE CODEOWNERS"`: Markdown files (including this one) are never linked.
- `SYMLINK_DIRS="config/*"`: each `config/<name>` is linked as a whole directory to `~/.config/<name>`. New files inside an existing `config/<name>` work right away. A new top-level entry needs `rcup`.

Do not edit `~/dotfiles` (upstream thoughtbot). Put every change here.

## Commands

```sh
lsrc                 # preview what rcm would link
rcup -v              # link new files into $HOME (run after adding a top-level file/dir)
exec zsh             # reload shell config
tmux source-file ~/.tmux.conf   # or prefix (C-a) then r
stylua config/nvim   # format Neovim Lua (config in config/nvim/stylua.toml)
```

## Tool stack

- **Shell:** zsh + zinit plugins (`zsh/configs/post/plugins.zsh`, zinit from Homebrew), starship prompt (`config/starship.toml`), mise for runtimes.
- **Editor:** Neovim with LazyVim (`config/nvim`). Custom plugin specs go in `config/nvim/lua/plugins/*.lua`. `example.lua` is the LazyVim template and returns `{}` early, so it does nothing. `lazy-lock.json` pins plugin versions; commit it after `:Lazy update`.
- **Terminal:** Ghostty (`config/ghostty/config`).
- **Multiplexer:** tmux with prefix `C-a` and TPM plugins listed in `tmux.conf.local`. The `run '~/.tmux/plugins/tpm/tpm'` line must stay last.
- **Theme:** TokyoNight Moon is used everywhere (Ghostty, Neovim, tmux status palette). Keep new UI colors on this palette.

## Conventions

- `.editorconfig`: 2-space indent, LF, final newline (Python 4 spaces, Makefile tabs).
- Commits use Conventional Commits (`feat: ...`).
- Guard optional tools with `command -v <tool> >/dev/null || return` (or `if command -v ...`) so the shell still starts on machines that don't have them.
