-- An extension for nvim-dap providing configurations for launching go debugger (delve) and debugging individual tests
--    https://github.com/leoluz/nvim-dap-go
local M = {
  -- Adapter for Go
  "leoluz/nvim-dap-go",
}
function M.config()
  require("dap-go").setup()
end

return M
