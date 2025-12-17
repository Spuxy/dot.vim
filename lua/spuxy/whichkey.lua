local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
    layout = {
      width = { min = 5, max = 50 },
      spacing = 10,
      align = "center",
    },
    sort = { "alphanum" },
    icons = {
      breadcrumb = lvim.icons.ui.DoubleChevronRight, -- symbol used in the command line area that shows your active key combo
      separator = lvim.icons.ui.BoldArrowRight, -- symbol used between a key and it's label
      group = lvim.icons.ui.Plus, -- symbol prepended to a group
    },
  },
  config = function(_, opts)
    require("which-key").setup(opts)
    require("which-key").register({
      q = { "<cmd>confirm q<CR>", "Quit" },
      e = { "<cmd>Lexplore <CR>", "Explore" },
      H = { "<cmd>nohlsearch<CR>", "NOHL" },
      [";"] = { "<cmd>tabnew | terminal<CR>", "Term" },
      v = { "<cmd>vsplit<CR>", "Vertical Split" },
      h = { "<cmd>split<CR>", "Horizontal Split" },
      y = { "<cmd>Telescope projects<CR>", "Projects" },
      b = { name = "Buffers" },
      d = { name = "Debug", desc = "Dap Debugger" },
      f = { name = "Find" },
      g = { name = "Git", desc = "Git Commands" },
      n = { name = "Todos" },
      p = { name = "Plugins" },
      t = { name = "Test", desc = "Testing" },
      l = { name = "LSP", desc = "Language Server Protocol" },
      a = {
        name = "Tab",
        n = { "<cmd>$tabnew<cr>", "New Empty Tab" },
        N = { "<cmd>tabnew %<cr>", "New Tab" },
        o = { "<cmd>tabonly<cr>", "Only" },
        h = { "<cmd>-tabmove<cr>", "Move Left" },
        l = { "<cmd>+tabmove<cr>", "Move Right" },
      },
      T = { name = "Treesitter" },
      m = { name = "Misc", desc = "Small programs", icon = "⚙️" },
      s = { name = "Search", icom = "🔍" },
    }, {
      mode = "n", -- NORMAL mode
      prefix = "<leader>",
    })
  end,
}

return M
