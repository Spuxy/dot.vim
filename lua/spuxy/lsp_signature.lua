local M = {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  opts = {
    bind = true,
    handler_opts = {
      border = "rounded",
    },
  },
  config = function(_, opts)
    require("lsp_signature").setup(opts)
  end,
}

function M.config()
  require("lsp_signature").setup({})
end

return M
