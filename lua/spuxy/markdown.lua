-- Render markdown in-buffer with decorations (headings, code blocks, bullets, etc.)
--    github.com/MeanderingProgrammer/render-markdown.nvim
local M = {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown" },
  opts = {
    file_types = { "markdown" },
    render_modes = { "n" },
    debounce = 100,
    anti_conceal = { enabled = true },
    heading = { enabled = true },
    code = { enabled = true },
    bullet = { enabled = true },
    checkbox = { enabled = true },
    table = { enabled = true },
    link = { enabled = true },
    -- Extend to nofile buftypes so lspsaga hover_doc and noice popups also render
    overrides = {
      buftype = {
        nofile = {
          enabled = true,
          heading = { enabled = false }, -- keep hover floats clean
        },
      },
    },
  },
}

return M
