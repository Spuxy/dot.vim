local M = {
  "0xstepit/flow.nvim",
  as = 'flow',
  lazy = false,
  priority = 1000,
  opts = {},
}

function M.config()
  vim.cmd.colorscheme("flow")
end

return M
