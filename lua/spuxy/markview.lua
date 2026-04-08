-- Markdown renderer — active replacement for render-markdown.nvim
--    github.com/OXY2DEV/markview.nvim
local M = {
  "OXY2DEV/markview.nvim",
  ft = { "markdown" },
  opts = {
    preview = {
      filetypes = { "markdown" },
    },
  },
}

return M
