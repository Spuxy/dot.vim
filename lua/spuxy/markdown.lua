-- Render markdown in-buffer with decorations (headings, code blocks, bullets, etc.)
--    github.com/MeanderingProgrammer/render-markdown.nvim
local M = {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown" },
  opts = {
    -- Only process actual markdown files, not floating windows from LSP hover/signature
    file_types = { "markdown" },
    -- Render only in normal mode — "c" (command mode) caused treesitter node races
    render_modes = { "n" },
    -- Debounce re-renders to avoid racing with treesitter tree invalidation
    debounce = 100,
    anti_conceal = { enabled = true },
    heading = { enabled = true },
    code = { enabled = true },
    bullet = { enabled = true },
    checkbox = { enabled = true },
    table = { enabled = true },
    link = { enabled = true },
  },
}

return M
