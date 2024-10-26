local M = {
  -- DAP (Debug Adapter Protocol) for Go
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui", -- UI for nvim-dap
    "mortepau/codicons.nvim",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-telescope/telescope-dap.nvim",
  },
}

function M.config()
  -- DAP UI setup
  require("dapui").setup()
  -- Virtual Text
  require("nvim-dap-virtual-text").setup()
  -- Telescope load extension
  require('telescope').load_extension('dap')

  require('spuxy.debug.go')
  require('spuxy.debug.python')
end

return M
