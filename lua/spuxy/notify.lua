local M = {
  "rcarriga/nvim-notify",
  opts = {
    background_colour = "#000000",
  },
}

function M.config(_, opts)
  require("notify").setup(opts)
end

return M
