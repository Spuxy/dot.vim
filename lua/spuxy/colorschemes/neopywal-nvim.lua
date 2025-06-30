local M = {
  'RedsXDD/neopywal.nvim',
  as = 'neopywal',
  lazy = false,
  priority = 1000,
}


function M.config()
  require("neopywal").setup({
    use_wallust = false,
  })
  vim.cmd.colorscheme("neopywal")
end

return M
