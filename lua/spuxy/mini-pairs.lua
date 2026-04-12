local M = {
  "nvim-mini/mini.pairs",
  event = "InsertEnter",
  opts = {
    modes = { insert = true, command = false, terminal = false },
  },
}

return M
