local M = {
  "nvim-mini/mini.splitjoin",
  keys = {
    { "<leader>ms",  "",  desc = "Split/Join" },
    { "<leader>mst", desc = "Toggle" },
    { "<leader>msj", desc = "Join" },
    { "<leader>mss", desc = "Split" },
  },
  opts = {
    mappings = {
      toggle = "<leader>mst",
      split  = "<leader>mss",
      join   = "<leader>msj",
    },
  },
}

return M
