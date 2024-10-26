local M = {
  'nvim-telescope/telescope.nvim', tag = '0.1.7',
  requires = { {'nvim-lua/plenary.nvim'} },
  dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true } }
}

function registerKeys()
  local whichkey = require("which-key")
  whichkey.register {
    ["<leader>bb"] = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
    ["<leader>fb"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    ["<leader>fc"] = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find files" },
    ["<leader>fp"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
    ["<leader>ft"] = { "<cmd>Telescope live_grep<cr>", "Find Text" },
    ["<leader>fh"] = { "<cmd>Telescope help_tags<cr>", "Help" },
    ["<leader>fl"] = { "<cmd>Telescope resume<cr>", "Last Search" },
    ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Recent File" },

    ["<leader>sb"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    -- ["<leader>sc"] = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" }, -- because of treesitter selection
    ["<leader>sf"] = { "<cmd>Telescope find_files<cr>", "Find File" },
    ["<leader>sh"] = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    ["<leader>sH"] = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
    ["<leader>sM"] = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    ["<leader>sr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    ["<leader>sR"] = { "<cmd>Telescope registers<cr>", "Registers" },
    ["<leader>st"] = { "<cmd>Telescope live_grep<cr>", "Text" },
    ["<leader>sk"] = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    ["<leader>sC"] = { "<cmd>Telescope commands<cr>", "Commands" },
    ["<leader>sl"] = { "<cmd>Telescope resume<cr>", "Resume last search" },
  }
end

function M.config()
  registerKeys()

  local icons = require("spuxy.icons")
  local actions = require("telescope.actions")


  require("telescope").setup {
    defaults = {
      layout_config = {
        vertical = { width = 7.0 },
      },
      prompt_prefix = icons.ui.Telescope .. " ",
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
        -- "--hidden",
        "--glob=!.git/",
      },

      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
        n = {
          ["<esc>"] = actions.close,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["q"] = actions.close,
        },
      },
    },
    pickers = {
      live_grep = {
        theme = "dropdown",
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
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
      },

      planets = {
        show_pluto = true,
        show_moon = true,
      },

      colorscheme = {
        enable_preview = true,
      },

      lsp_references = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_definitions = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_declarations = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_implementations = {
        theme = "dropdown",
        initial_mode = "normal",
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
  }
end
-- https://github.com/nvim-telescope/telescope.nvim/issues/3070
return M
