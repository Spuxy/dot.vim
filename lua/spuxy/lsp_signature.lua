local M = {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  opts = {},
}
function M.config()
  require('lsp_signature').setup({})
end

return M
