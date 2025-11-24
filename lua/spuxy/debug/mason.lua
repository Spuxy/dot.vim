local defaults = require("spuxy.defaults.tools")
local M = {
  "jay-babu/mason-nvim-dap.nvim",
  opts = {
    automatic_installation = true,
    ensure_installed = defaults.debuggers,
  },
  config = function(_, opts)
    require("mason-nvim-dap").setup(opts)
  end
}


return M
