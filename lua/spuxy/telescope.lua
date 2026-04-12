local keys = require("spuxy.defaults.mappings.telescope")
local icons = require("spuxy.core.icons")

local M = {
  "nvim-telescope/telescope.nvim",
  branch = "master",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
    { "ahmedkhalf/project.nvim" },
  },
  keys = {
    { "<leader>y", "<cmd>Telescope projects<cr>", desc = "Projects" },
    { "<leader>[", "<cmd>CustomFinder<CR>", "lll" },
    {
      "<leader>]",
      function()
        local builtin = require("telescope.builtin")
        local local_opts = {}
        local ok = pcall(builtin.git_files, local_opts)
        if not ok then
          builtin.find_files(local_opts)
        end
      end,
      "lpl",
    },
  },
  opts = {
    ---@usage disable telescope completely [not recommended]
    active = true,
    on_config_done = nil,
    theme = "dropdown", ---@type telescope_themes
    defaults = {
      prompt_prefix = icons.ui.Telescope .. " ",
      selection_caret = icons.ui.Forward .. " ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = nil,
      layout_strategy = nil,
      layout_config = {},
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
      ---@usage Mappings are fully customizable. Many familiar mapping patterns are setup as defaults.
      mappings = keys.default,
      file_ignore_patterns = {},
      path_display = { "smart" },
      winblend = 0,
      border = {},
      borderchars = nil,
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    },
    pickers = {
      find_files = {
        hidden = true,
      },
      live_grep = {
        --@usage don't include the filename in the search results
        only_sort_text = true,
      },
      grep_string = {
        only_sort_text = true,
      },
      buffers = {
        initial_mode = "normal",
        mappings = keys.buffer,
      },
      planets = {
        show_pluto = true,
        show_moon = true,
      },
      git_files = {
        hidden = true,
        show_untracked = true,
      },
      colorscheme = {
        enable_preview = true,
      },
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
    },
  },
}

M.config = function(_, opts)
  require("telescope").setup(opts)
  require("telescope").load_extension("fzf")
  require("telescope").load_extension("projects")

  require("project_nvim").setup({
    manual_mode = false,
    detection_methods = { "pattern" },
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pom.xml" },
    ignore_lsp = {},
    exclude_dirs = {},
    show_hidden = false,
    silent_chdir = true,
    scope_chdir = "global",
  })
  keys.whichkey()
end

return M
