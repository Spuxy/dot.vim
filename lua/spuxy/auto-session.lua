-- A small automated session manager for Neovim
--    github.com/rmagatti/auto-session
local M = {
  "rmagatti/auto-session",
  lazy = false,
  dependencies = {
    "nvim-lualine/lualine.nvim"
  },
  keys = {
    { "<leader>mS",  "",                               desc = "Sessions" },
    { "<leader>mSs", "<cmd>SessionSearch<CR>",         desc = "Session search" },
    { "<leader>mSw", "<cmd>SessionSave<CR>",           desc = "Save session" },
    { "<leader>mSa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
  },
  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    -- ⚠️ This will only work if Telescope.nvim is installed
    -- The following are already the default values, no need to provide them if these are already the settings you want.
    suppressed_dirs = { "~/", "~/Projects", "~/Programming", "~/Working", "~/Downloads", "/" },
  },
}



return M
