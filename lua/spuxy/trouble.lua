local M = {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {
    auto_preview = false,
    auto_close = true,
    focus = true,
    modes = {
      preview_diagnostics = {
        mode = "diagnostics",
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.3,
        },
      },
    },
  },
  config = function(_, opts)
    require("trouble").setup(opts)
  end
}

return M
