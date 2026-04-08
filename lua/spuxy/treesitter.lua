local defaults = require("spuxy.defaults.tools")
local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "RRethy/nvim-treesitter-endwise",
    "windwp/nvim-ts-autotag",
    { "nvim-mini/mini.ai", event = { "BufReadPre", "BufNewFile" }, opts = {} },
  },
  build = ":TSUpdate",
  opts = {
    ignore_install = {},
    auto_install = true,
    sync_install = false,
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
    -- Workaround: nvim-treesitter's set-lang-from-info-string! predicate crashes
    -- in Neovim 0.11+ when processing markdown injection queries (fenced code
    -- block language detection). Clear the query until nvim-treesitter is updated.
    -- Remove this once `:Lazy update nvim-treesitter` fixes the issue.
    vim.treesitter.query.set("markdown", "injections", "")
  end,
}

return M
