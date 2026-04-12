-- defaults/plugins.lua — settings consumed by other config files
--
-- Only keep entries here if an active plugin file reads them.
-- Stale entries for removed plugins belong in DECISION_PLUGINS.md, not here.

return {
  plugins = {
    lazy = {
      dev = {
        path = "$HOME/workspace/github.com/",
      },
      disable_neovim_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        -- "tarPlugin",
        -- "tohtml",
        -- "tutor",
        -- "zipPlugin",
      },
    },
    lsp = {
      log = "off",
    },
    git = {
      -- which tool to use for handling git merge conflicts
      -- choose between "git-conflict" and "diffview" or "both"
      merge_conflict_tool = "git-conflict",
    },
    symbol_usage = {
      enable = true,
      opts = {
        vt_position = "above", -- 'above'|'end_of_line'|'textwidth'
      },
    },
  },
}
