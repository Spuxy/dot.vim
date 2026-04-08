local M = {
  "mrjones2014/smart-splits.nvim",
  keys = {
    {
      "<C-S-h>",
      function()
        require("smart-splits").resize_left()
      end,
      desc = "Resize to left",
      mode = "n",
    },
    {
      "<C-S-l>",
      function()
        require("smart-splits").resize_right()
      end,
      desc = "Resize to right",
      mode = "n",
    },
    {
      "<C-S-k>",
      function()
        require("smart-splits").resize_up()
      end,
      desc = "Resize to up ",
      mode = "n",
    },
    {
      "<C-S-j>",
      function()
        require("smart-splits").resize_down()
      end,
      desc = "Resize to down",
      mode = "n",
    },

    {
      "<leader>bmj",
      function()
        require("smart-splits").swap_buf_down()
      end,
      desc = "Swap to down",
      mode = "n",
    },
    {
      "<leader>bmk",
      function()
        require("smart-splits").swap_buf_up()
      end,
      desc = "Swap to up",
      mode = "n",
    },
    {
      "<leader>bmh",
      function()
        require("smart-splits").swap_buf_left()
      end,
      desc = "Swap to up left",
      mode = "n",
    },
    {
      "<leader>bml",
      function()
        require("smart-splits").swap_buf_right()
      end,
      desc = "Swap to right",
      mode = "n",
    },
  },
  config = function()
    vim.keymap.set("n", "<A-j>", "<Cmd>echo \"Alt-j pressed\"<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
    vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
    vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
    vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)

    vim.keymap.set("n", "<S-C-h>", require("smart-splits").swap_buf_left)
    vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
    vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
    vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
  end,
  lazy = true,
}

return M
