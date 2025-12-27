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
    suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    -- log_level = 'debug',
    session_lens = {
      -- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
      load_on_setup = true,
      previewer = false,
      mappings = {
        -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
        delete_session = { "i", "<C-D>" },
        alternate_session = { "i", "<C-S>" },
        copy_session = { "i", "<C-Y>" },
      },
      -- Can also set some Telescope picker options
      -- For all options, see: https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt#L112
      theme_conf = {
        border = true,
        -- layout_config = {
        --   width = 0.8, -- Can set width and height as percent of window
        --   height = 0.5,
        -- },
      },
    },
  },
  config = function(_, opts)
    require("auto-session").setup(opts)
  end,
}
return M
