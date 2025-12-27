local M = {
  {
    "fredrikaverpil/godoc.nvim",
    version = "*",
    dependencies = {
      { "nvim-telescope/telescope.nvim" }, -- optional
      { "folke/snacks.nvim" }, -- optional
      { "echasnovski/mini.pick" }, -- optional
      { "ibhagwan/fzf-lua" }, -- optional
    },
    build = "go install github.com/lotusirous/gostdsym/stdsym@latest", -- optional
    cmd = { "GoDoc" }, -- optional
    ft = "godoc", -- optional
    opts = {}, -- see further down below for configuration
  }
}

return M
