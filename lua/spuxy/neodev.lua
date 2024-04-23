local M = {
  "folke/neodev.nvim",
  opts = {}
}

function M.config()
  require("neodev").setup({})
end

return M
