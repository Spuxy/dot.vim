-- Smart split navigation + resizing with WezTerm pane passthrough
--    github.com/mrjones2014/smart-splits.nvim
--
-- <C-h/j/k/l>        — move cursor between Neovim splits OR WezTerm panes seamlessly
-- <A-h/j/k/l>        — resize the current split directionally
-- <leader>w<H/J/K/L> — swap the current buffer with an adjacent split
--
-- WezTerm setup (one-time, in your wezterm.lua):
--   local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
--   smart_splits.apply_to_config(config)

local M = {
  "mrjones2014/smart-splits.nvim",
  opts = {
    -- How many lines/columns to resize by per keypress
    default_amount = 3,
    -- Stop at edges rather than wrapping to the other side
    at_edge = "stop",
    -- WezTerm: seamless navigation between Neovim splits and WezTerm panes
    multiplexer_integration = "wezterm",
    -- Don't interfere with these buffer types when resizing
    ignored_buftypes = { "nofile", "quickfix", "prompt" },
    ignored_filetypes = { "neo-tree" },
  },
  keys = {
    -- Move cursor (replaces plain <C-w>hjkl — also works across WezTerm panes)
    { "<C-h>", function() require("smart-splits").move_cursor_left()  end, desc = "Move to left split" },
    { "<C-j>", function() require("smart-splits").move_cursor_down()  end, desc = "Move to lower split" },
    { "<C-k>", function() require("smart-splits").move_cursor_up()    end, desc = "Move to upper split" },
    { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },

    -- Resize splits directionally
    { "<A-h>", function() require("smart-splits").resize_left()  end, desc = "Resize left" },
    { "<A-j>", function() require("smart-splits").resize_down()  end, desc = "Resize down" },
    { "<A-k>", function() require("smart-splits").resize_up()    end, desc = "Resize up" },
    { "<A-l>", function() require("smart-splits").resize_right() end, desc = "Resize right" },

    -- Swap buffers between splits (keeps cursor in original window)
    { "<leader>wH", function() require("smart-splits").swap_buf_left()  end, desc = "Swap left" },
    { "<leader>wJ", function() require("smart-splits").swap_buf_down()  end, desc = "Swap down" },
    { "<leader>wK", function() require("smart-splits").swap_buf_up()    end, desc = "Swap up" },
    { "<leader>wL", function() require("smart-splits").swap_buf_right() end, desc = "Swap right" },
  },
}

return M
