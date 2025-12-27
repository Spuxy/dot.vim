-- A hackable markdown, Typst, latex, html(inline) & YAML previewer for Neovim
--    github.com/OXY2DEV/markview.nvim?tab=readme-ov-file#-installation
local M = {
  "OXY2DEV/markview.nvim",
  lazy = false,
  -- Completion for `blink.cmp`
  dependencies = { "saghen/blink.cmp" },
}

return M
