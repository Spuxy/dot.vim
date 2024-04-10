local M ={
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {}
}

function M.config()
   require("todo-comments")
  local wk = require "which-key"
  wk.register {
      ["<leader>nn"] = { "<cmd>TodoTrouble<cr>", "Term" },
      ["<leader>nf"] = { "<cmd>TodoTelescope<cr>", "Telescope" },
  }
end

return M
