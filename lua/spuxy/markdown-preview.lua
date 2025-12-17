-- markdown preview plugin for (neo)vim
--    github.com/iamcco/markdown-preview.nvim
local M = {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  keys = {
    { "<leader>mm", "", desc = "Markdown" },
    { "<leader>mmp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Preview Toggle" },
  },
}

return M
