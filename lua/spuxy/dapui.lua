local M = {
  -- DAP (Debug Adapter Protocol) for Go
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui", -- UI for nvim-dap
    "leoluz/nvim-dap-go", -- DAP integration for Go
    "mortepau/codicons.nvim",
  },
  lazy = true,
}

function M.config()
  -- DAP UI setup
  require("dapui").setup()
  -- Go adapter setup
  require("dap-go").setup()
end

return M
