local keys = require("spuxy.defaults.mappings.todo-comments")

local M = {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "VeryLazy" },
  opts = {},
  keys = keys.whichkey,
  config = function()
    require("todo-comments").setup()
  end,
}

return M
