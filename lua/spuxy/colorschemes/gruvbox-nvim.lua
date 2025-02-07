local M = {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  opts = {
    transparent = vim.g.transparent_enabled,
    transparent_mode = true,
    contrast = "hard",
    palette_overrides = {
      dark0_hard = "#000000",
    },
    -- https://github.com/ellisonleao/gruvbox.nvim/pull/361
    overrides = {
      NoiceCmdlinePopupBorder = { bg = nil },
    },
  },
  config = function(_, opts)
    require("gruvbox").setup(opts)
    vim.o.background = "dark"
    vim.cmd.colorscheme("gruvbox")
  end,
}
return M
