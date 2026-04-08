local M = {
  "ray-x/lsp_signature.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    bind = true,
    handler_opts = {
      border = "rounded",
    },
    floating_window = true,
    hint_enable = true,
    hint_prefix = "󰊕 ",
    hi_parameter = "Search", -- highlight the current parameter
    -- No select_signature_key here — Tab is used by nvim-cmp
  },
  config = function(_, opts)
    require("lsp_signature").setup(opts)
  end,
}

return M
