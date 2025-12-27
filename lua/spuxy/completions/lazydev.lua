local M = {
  "folke/lazydev.nvim",
  dependencies = { "saghen/blink.cmp" },
  ft = "lua",
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "snacks.nvim", words = { "Snacks" } },
    },
  },
}

return M
