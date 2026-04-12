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
      separator = icons.ui.BoldArrowRight, -- symbol used between a key and it's label
      group = icons.ui.Plus, -- symbol prepended to a group
    },
    win = {
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    },
    ignore_missing = false,
  },
  keys = {
    -- Direct mappings
    { "<leader>q", "<cmd>confirm q<CR>",                      desc = "Quit" },
    { "<leader>H", "<cmd>nohlsearch<CR>",                     desc = "No Highlight" },
    { "<leader>;", function() Snacks.dashboard() end,         desc = "Dashboard" },
    { "<leader>v", "<cmd>vsplit<CR>",                         desc = "Vertical Split" },
    { "<leader>h", "<cmd>split<CR>",                          desc = "Horizontal Split" },
    { "<leader>y", "<cmd>Telescope projects<CR>",             desc = "Projects" },
    { "<leader>/", "gcc", desc = "Comment line", remap = true },
    { "<leader>c", function() Snacks.bufdelete() end,         desc = "Close Buffer" },

    -- Health
    { "<leader>pha", "<cmd>checkhealth<cr>",           desc = "All" },
    { "<leader>phs", "<cmd>checkhealth snacks<cr>",    desc = "Snacks" },
    { "<leader>phl", "<cmd>checkhealth lazy<cr>",      desc = "Lazy" },
    { "<leader>pht", "<cmd>checkhealth telescope<cr>", desc = "Telescope" },
    { "<leader>phL", "<cmd>checkhealth lsp<cr>",       desc = "LSP" },
    { "<leader>phm", "<cmd>checkhealth mason<cr>",     desc = "Mason" },

    -- Tabs
    { "<leader>an", "<cmd>$tabnew<cr>",     desc = "New Empty Tab" },
    { "<leader>aN", "<cmd>tabnew %<cr>",    desc = "New Tab" },
    { "<leader>ac", "<cmd>tabclose<cr>",    desc = "Close Tab" },
    { "<leader>ao", "<cmd>tabonly<cr>",     desc = "Close Others" },
    { "<leader>aj", "<cmd>tabnext<cr>",     desc = "Next Tab" },
    { "<leader>ak", "<cmd>tabprevious<cr>", desc = "Prev Tab" },
    { "<leader>ah", "<cmd>-tabmove<cr>",    desc = "Move Left" },
    { "<leader>al", "<cmd>+tabmove<cr>",    desc = "Move Right" },
  },
  config = function(_, opts)
    require("which-key").setup(opts)
    require("which-key").add({
      -- Top-level groups
      { "<leader>b",  group = "Buffers",    icon = { icon = "󰓩",                    color = "blue" } },
      { "<leader>f",  group = "Files",      icon = { icon = "󰈔",                    color = "blue" } },
      { "<leader>w",  group = "Windows",    icon = { icon = "󰖯",                    color = "cyan" } },
        { "<leader>ws", group = "Splits",   icon = { icon = "󰤿",                    color = "cyan" } },
      { "<leader>d",  group = "Debug",      icon = { icon = icons.ui.DebugConsole,   color = "red" } },
        { "<leader>dP", group = "Python",   icon = { icon = icons.language.python,   color = "yellow" } },
      { "<leader>g",  group = "Git",        icon = { icon = icons.git.Octoface,      color = "orange" } },
      { "<leader>n",  group = "Todos",      icon = { icon = icons.ui.List,           color = "yellow" } },
      { "<leader>p",  group = "Plugins",    icon = { icon = "󰏖",                    color = "purple" } },
        { "<leader>ph", group = "Health",   icon = { icon = "󰑐",                    color = "green" } },
      { "<leader>q",  group = "Quickfix",   icon = { icon = "󰁨",                    color = "orange" } },
      { "<leader>k",  group = "Kustomize",  icon = { icon = "󱃾",                    color = "cyan" } },
      { "<leader>r",  group = "Replace",    icon = { icon = "󰛔",                    color = "orange" } },
      { "<leader>s",  group = "Search",     icon = { icon = icons.ui.Search,         color = "yellow" } },
      { "<leader>t",  group = "Test",       icon = { icon = icons.ui.BoxChecked,     color = "green" } },
      { "<leader>x",  group = "Swap",       icon = { icon = "󰓡",                    color = "cyan" } },
      { "<leader>z",  group = "Spelling",   icon = { icon = "󰓆",                    color = "blue" } },
      { "<leader>l",  group = "LSP",        icon = { icon = icons.ui.Code,           color = "blue" } },
        { "<leader>ld",  group = "Debugging",  icon = { icon = icons.ui.Bug,         color = "red" } },
        { "<leader>lp",  group = "Peek",       icon = { icon = icons.ui.EmptyFolder, color = "grey" } },
        { "<leader>lg",  group = "Go",         icon = { icon = icons.language.go,    color = "cyan" } },
          { "<leader>lgf", group = "Fill",     icon = { icon = icons.ui.EmptyFolder, color = "grey" } },
      { "<leader>a",  group = "Tab",        icon = { icon = "󰌒",                    color = "blue" } },
      { "<leader>T",  group = "Toggle",     icon = { icon = "󰔡",                    color = "orange" } },
      { "<leader>C",  group = "Copilot",    icon = { icon = icons.git.Copilot,       color = "grey" } },
      { "<leader>m",  group = "Misc",       icon = { icon = icons.ui.Gear,           color = "grey" } },
        { "<leader>mS",  group = "Sessions",   icon = { icon = "󰁯",                 color = "purple" } },
        { "<leader>mn",  group = "Notify",     icon = { icon = icons.ui.List,        color = "grey" } },
        { "<leader>mx",  group = "Trouble",    icon = { icon = icons.diagnostics.BoldError, color = "red" } },
        { "<leader>mT",  group = "Transparency", icon = { icon = "󰇄",              color = "grey" } },
        { "<leader>mm",  group = "Markdown",   icon = { icon = "󰍔",                color = "blue" } },
        { "<leader>mt",  group = "Todo",       icon = { icon = icons.ui.Note,       color = "yellow" } },
        { "<leader>ms",  group = "Split/Join", icon = { icon = "󰓡",                color = "orange" } },
        { "<leader>mac", group = "Copilot",    icon = { icon = icons.git.Copilot,   color = "grey" } },
    })
  end,
}

return M
