local M = {
  'AlphaTechnolog/pywal.nvim',
  as = 'pywal',
}


function M.config()
  require("pywal").setup({})
  local lualine = require('lualine')
  lualine.setup {
    options = {
      theme = 'pywal-nvim',
    },
  }
end

return M
