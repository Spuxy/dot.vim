local M = {
  "neogitorg/neogit",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",  -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed, not both.
    "nvim-telescope/telescope.nvim", -- optional
    "ibhagwan/fzf-lua",              -- optional
  },
  keys = {
    { "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit" },
  },
  opts = {
    auto_refresh = true,
    disable_builtin_notifications = false,
    use_magit_keybindings = false,
    -- Change the default way of opening neogit
    kind = "tab",
    -- Change the default way of opening the commit popup
    commit_popup = {
      kind = "split",
    },
    -- Change the default way of opening popups
    popup = {
      kind = "split",
    },
    -- customize displayed signs
    signs = {
      -- { CLOSED, OPENED }
      section = { require("spuxy.icons").ui.ChevronRight, require("spuxy.icons").ui.ChevronShortDown },
      item = { require("spuxy.icons").ui.ChevronRight, require("spuxy.icons").ui.ChevronShortDown },
      hunk = { "", "" },
    },
  },
  config = true
}

return M
