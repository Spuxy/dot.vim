-- An extension for nvim-dap providing configurations for launching go debugger (delve) and debugging individual tests
--    https://github.com/leoluz/nvim-dap-go
local M = {
  -- Adapter for Go
  "leoluz/nvim-dap-go",
}
function M.config()
  require("dap-go").setup({
    delve = {
      -- Suppress Go version check: Mason's delve may lag behind the installed
      -- Go release but still works in practice
      args = { "--check-go-version=false" },
    },
  })
end

return M
