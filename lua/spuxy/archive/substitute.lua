local M = {
  "gbprod/substitute.nvim",
  opts = {},
  config = function(_, opts)
    require("substitute").setup(opts)
  end,
}

return M
