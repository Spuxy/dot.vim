local M = {
  "Wansmer/treesj",
  keys = {
    { "<leader>ms",  "",                   desc = "TreeSJ" },
    { "<leader>mst", "<cmd>TSJToggle<cr>", desc = "Toggle" },
    { "<leader>msj", "<cmd>TSJJoin<cr>",   desc = "Join" },
    { "<leader>mss", "<cmd>TSJSplit<cr>",  desc = "Split" },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    use_default_keymaps = false,
  },
  config = true,
}

return M
