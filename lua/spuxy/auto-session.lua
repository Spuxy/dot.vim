-- A small automated session manager for Neovim
--    github.com/rmagatti/auto-session
local M = {
  "rmagatti/auto-session",
  lazy = false,
  dependencies = {
    "nvim-lualine/lualine.nvim",
  },
  keys = {
    { "<leader>mS", "", desc = "Sessions" },
    { "<leader>mSs", "<cmd>AutoSession search<CR>", desc = "Session search" },
    { "<leader>mSw", "<cmd>SessionSave<CR>", desc = "Save session" },
    { "<leader>mSa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
  },
  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    auto_restore = false, -- never auto-restore; use SessionSearch from alpha or <leader>mSs
    suppressed_dirs = { "~/", "~/Projects", "~/Programming", "~/Working", "~/Downloads", "/" },
  },
}

return M
