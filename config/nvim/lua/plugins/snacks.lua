-- Snacks.image: renders images, Mermaid diagrams and LaTeX math inline in Neovim.
-- Disabled for now. Ghostty already supports the needed graphics protocol,
-- but the converters below are not installed, so :checkhealth reports them missing.
--
-- To enable, install the external tools first:
--   brew install imagemagick    -- magick: images (without it, only PNG works)
--   brew install ghostscript    -- gs:     PDF files
--   brew install mermaid-cli    -- mmdc:   ```mermaid code blocks
--   brew install tectonic       -- LaTeX math expressions
--
-- Then set image.enabled = true below and restart Neovim.
-- Docs: https://github.com/folke/snacks.nvim/blob/main/docs/image.md

return {
  "folke/snacks.nvim",
  opts = {
    image = { enabled = false },
  },
}
