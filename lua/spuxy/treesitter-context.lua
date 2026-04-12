-- treesitter-context — sticky scroll (VSCode-style)
--
-- Pins the current function/class/block header at the top of the window
-- so you always know where you are in deeply nested code.

local M = {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    enable = true,
    max_lines = 3,          -- max context lines pinned at top
    min_window_height = 20, -- don't show context in small windows
    line_numbers = true,
    multiline_threshold = 1, -- show context even for single-line scopes
    trim_scope = "outer",   -- prefer outer context when truncating
    mode = "cursor",        -- show context of the line under cursor
    separator = "─",        -- visual separator between context and code
  },
  keys = {
    {
      "gC",
      function() require("treesitter-context").go_to_context(vim.v.count1) end,
      desc = "Jump to context (sticky header)",
    },
  },
}

return M
