local M = {
  "xiyaowong/transparent.nvim",
  keys = {
    { "<leader>mT",  "",                            desc = "Transparency" },
    { "<leader>mTt", "<cmd>TransparentToggle<cr>",  desc = "Toggle" },
    { "<leader>mTe", "<cmd>TransparentEnable<cr>",  desc = "Enable" },
    { "<leader>mTd", "<cmd>TransparentDisable<cr>", desc = "Disable" },
  },
  config = function()
    require("transparent").setup()
  end,
}
return M
