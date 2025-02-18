local M = {
  -- Adapter for Go
  "leoluz/nvim-dap-go",
}
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#Go
function M.config()
  require("dap-go").setup()

  local dap = require("dap")
  dap.adapters.go = {
    type = "executable",
    command = "node",
    args = { "/Users/filip.boye.kofi/Upstreams/vscode-go/extension/dist/debugAdapter.js" },
  }
  dap.configurations.go = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      showLog = false,
      program = "${file}",
      dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
    },
  }
end

return M
