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
    -- Replace nvim-treesitter's markdown injection query with a safe version that
    -- avoids the set-lang-from-info-string! predicate (crashes Neovim 0.11+ on nil
    -- nodes). Uses explicit @injection.language capture instead.
    vim.treesitter.query.set("markdown", "injections", [[
      (fenced_code_block
        (info_string
          (language) @injection.language)
        (code_fence_content) @injection.content
        (#set! injection.include-children))
    ]])
  end,
}

return M
