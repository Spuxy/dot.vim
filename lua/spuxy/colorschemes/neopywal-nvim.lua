local M = {
  'RedsXDD/neopywal.nvim',
  as = 'neopywal',
  lazy = false,
  priority = 1000,
}


function M.config()
  require("neopywal").setup()
  vim.cmd.colorscheme("neopywal")
end

return M
