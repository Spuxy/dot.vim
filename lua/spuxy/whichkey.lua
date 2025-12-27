--  💥 Create key bindings that stick. WhichKey helps you remember your Neovim keymaps, by showing available keybindings in a popup as you type.
--      github.com/folke/which-key.nvim
--  [[cheat sheet]]
--  <c-d> binding down scroll up inside the popup
--  <c-u> binding to scroll up inside the popup
--  [[!cheat shee]]
local icons = require("spuxy.core.icons")
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
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 10,
      align = "center",
    },
    sort = { "alphanum" },
    icons = {
      breadcrumb = icons.ui.DoubleChevronRight, -- symbol used in the command line area that shows your active key combo
      separator = icons.ui.BoldArrowRight,      -- symbol used between a key and it's label
      group = icons.ui.Plus,                    -- symbol prepended to a group
    },
    win = {
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    },
    ignore_missing = false,
  },
  keys = {
    -- Direct mappings
    { "<leader>q",  "<cmd>confirm q<CR>",                      desc = "Quit" },
    { "<leader>e",  "<cmd>NvimTreeToggle<CR>",                 desc = "Explore" },
    { "<leader>H",  "<cmd>nohlsearch<CR>",                     desc = "No Highlight" },
    -- { "<leader>;", "<cmd>tabnew | terminal<CR>", desc = "Term" },
    { "<leader>;",  "<cmd>Alpha<CR>",                          desc = "Dashboard" },
    { "<leader>v",  "<cmd>vsplit<CR>",                         desc = "Vertical Split" },
    { "<leader>h",  "<cmd>split<CR>",                          desc = "Horizontal Split" },
    { "<leader>y",  "<cmd>Telescope projects<CR>",             desc = "Projects" },

    { "<leader>/",  "<Plug>(comment_toggle_linewise_current)", desc = "Comment toggle current line" },
    { "<leader>c",  "<cmd>BufferKill<CR>",                     desc = "Close Buffer" },
    { "<leader>f",  "<cmd>CustomFinder<CR>",                   desc = "Find File" },

    { "<leader>an", "<cmd>$tabnew<cr>",                        desc = "New Empty Tab" },
    { "<leader>aN", "<cmd>tabnew %<cr>",                       desc = "New Tab" },
    { "<leader>ao", "<cmd>tabonly<cr>",                        desc = "Only" },
    { "<leader>ah", "<cmd>-tabmove<cr>",                       desc = "Move Left" },
    { "<leader>al", "<cmd>+tabmove<cr>",                       desc = "Move Right" },
  },
  config = function(_, opts)
    require("which-key").setup(opts)
    require("which-key").add({
      { "<leader>b", group = "Buffers", icon = "󰓩" },
      { "<leader>d", group = "Debug", icon = icons.ui.DebugConsole },
      { "<leader>f", group = "Find", icon = icons.ui.Telescope },
      { "<leader>g", group = "Git", icon = icons.git.Octoface },
      { "<leader>n", group = "Todos", icon = icons.ui.List },
      { "<leader>p", group = "Plugins", icon = "󰏖" },
      { "<leader>t", group = "Test", icon = icons.ui.BoxChecked },
      { "<leader>l", group = "LSP", icon = icons.ui.Code },
        { "<leader>ld", group = "Debugging", icon = icons.ui.Bug },
        { "<leader>lp", group = "Peek", icon = icons.ui.EmptyFolder },
        { "<leader>lg", group = "Go", icon = icons.language.go },
        { "<leader>lgf", group = "Fill", icon = icons.ui.EmptyFolder },
      { "<leader>a", group = "Tab", icon = icons.ui.File },
      { "<leader>T", group = "Treesitter", icon = "🌲 " },
      { "<leader>m", group = "Misc", icon = icons.ui.Gear },
      { "<leader>s", group = "Search", icon = "🔍" },
    })
  end,
}

return M
