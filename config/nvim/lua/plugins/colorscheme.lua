-- To switch:
--   1. add the theme plugin spec (see commented examples below)
--   2. set `colorscheme` in the LazyVim opts to that theme's name
--   3. restart Neovim
--
-- To preview installed themes without editing anything: <leader>uC
-- Theme names are the ones you pass to `:colorscheme`, not the repo names.

return {
  -- variants: tokyonight-night, tokyonight-storm, tokyonight-moon, tokyonight-day
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon",
    },
  },

  -- Tell LazyVim which one to load on startup.
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
