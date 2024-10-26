local M = {
  -- Adapter for Go
  "nvim-telescope/telescope-dap.nvim",
}

function M.config()
  require('telescope').load_extension('dap')
end

return M
