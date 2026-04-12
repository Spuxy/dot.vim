local M = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    suggestion = { enabled = false }, -- handled by blink-cmp-copilot
    panel = { enabled = false },      -- handled by blink-cmp-copilot
    filetypes = {
      markdown = true,
      yaml = true,
    },
  },
}

return M
