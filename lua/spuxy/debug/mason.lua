local M = {
  "williamboman/mason.nvim",
  "mfussenegger/nvim-dap",
  "jay-babu/mason-nvim-dap.nvim",
}

function M.config()
  require("mason").setup()
  require("mason-nvim-dap").setup()
end

return M
