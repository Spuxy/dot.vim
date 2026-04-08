--  Fuzzy search Go packages/symbols and view docs from within Neovim
--    github.com/fredrikaverpil/godoc.nvim
local M = {
  {
    "fredrikaverpil/godoc.nvim",
    version = "*",
    dependencies = {
      { "nvim-telescope/telescope.nvim" }, -- optional
      { "folke/snacks.nvim" }, -- optional
      { "nvim-mini/mini.pick" }, -- optional
      { "ibhagwan/fzf-lua" }, -- optional
    },
    build = "go install github.com/lotusirous/gostdsym/stdsym@latest", -- optional
    cmd = { "GoDoc" }, -- optional
    ft = "godoc", -- optional
    opts = {}, -- see further down below for configuration
  }
}

return M
