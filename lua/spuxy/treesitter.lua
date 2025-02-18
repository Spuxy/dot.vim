local defaults = require("spuxy.defaults.tools")
local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "RRethy/nvim-treesitter-endwise",
    "mfussenegger/nvim-ts-hint-textobject",
    "windwp/nvim-ts-autotag",
  },
  build = ":TSUpdate",
  opts = {
    ignore_install = {},
    auto_install = true,
    sync_install = false,
    autopairs = { enable = true },
    ensure_installed = defaults.treesitter,
    highlight = { enable = true },
    indent = {
      enable = true,
      -- disable = { "yaml" },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<leader>ss",
        node_incremental = "<leader>si",
        scope_incremental = "<leader>sc",
        node_decremental = "<leader>sd",
      },
    },
  },
  config = function(_, opts)
    require("nvim-ts-autotag").setup()
    require("nvim-treesitter.configs").setup(opts)
  end,
}

return M
