local utils = require("spuxy.defaults.ignored_files")
local keys = require("spuxy.defaults.mappings.telescope")
local command = require("spuxy.core.commands")
local M = {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.7',
  requires = { { 'nvim-lua/plenary.nvim' } },
  dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true } },
  keys = {
    { "<leader>[", "<cmd>CustomFinder<CR>" , "lll" },
    { "<leader>]",
      function()
        local builtin = require "telescope.builtin"
        opts = opts or {}
        local ok = pcall(builtin.git_files, opts)
        if not ok then
          builtin.find_files(opts)
        end
      end
      , "lpl" }
  }
}

function M.config()
  require("which-key").register(keys.whichkey)

  local icons = require("spuxy.core.icons")

  require("telescope").setup {
    defaults = {
      layout_config = {
        vertical = { width = 7.0 },
      },
      file_ignore_patterns = utils.ignored_files,
      prompt_prefix = " " .. icons.ui.Telescope .. " ",
      selection_caret = icons.ui.Forward .. "  ",
      entry_prefix = "   ",
      initial_mode = "insert",
      selection_strategy = "reset",
      path_display = { "smart" },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" },
      sorting_strategy = nil,
      layout_strategy = nil,
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },

      mappings = keys.default
    },
    pickers = {
      live_grep = {
        theme = "dropdown",
        only_sort_text = true,
      },

      grep_string = {
        theme = "dropdown",
      },

      find_files = {
        theme = "dropdown",
        previewer = true,
        path_display = { "absolute" },
      },

      buffers = {
        theme = "dropdown",
        previewer = false,
        initial_mode = "normal",
        ignore_current_buffer = true,
        sort_lastused = true,
        mappings = keys.buffer,
      },

      colorscheme = {
        enable_preview = true,
      },

    },
    extensions = {
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      },
    },
  }
end

-- https://github.com/nvim-telescope/telescope.nvim/issues/3070
return M
