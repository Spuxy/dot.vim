local M = {
  "uZer/pywal16.nvim",
  as = "pywal16",
  config = function()
    vim.cmd.colorscheme("pywal16")
    require("pywal16").setup({})
  end,
}

return M
