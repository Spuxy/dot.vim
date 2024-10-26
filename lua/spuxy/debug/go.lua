local M = {
  -- Adapter for Go
  "leoluz/nvim-dap-go",
}

function M.config()
  require("dap-go").setup()

  local dap = require("dap")
  dap.adapters.go = {
    type = 'executable',
    command = 'node',
    args = { os.getenv('HOME') .. '/Upstreams/vscode-go/extension/dist/debugAdapter.js' },
  }
  dap.configurations.go = {
    {
      type = 'go',
      name = 'Debug',
      request = 'launch',
      showLog = false,
      program = "${file}",
      dlvToolPath = vim.fn.exepath('dlv') -- Adjust to where delve is installed
    },
  }
end

return M
