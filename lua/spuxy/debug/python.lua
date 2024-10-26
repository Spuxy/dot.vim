local M = {
  "mfussenegger/nvim-dap-python",
}

function M.config()
  require("dap-python").setup("python3")
end

return M
