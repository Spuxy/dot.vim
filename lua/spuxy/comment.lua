local M = {
  'numToStr/Comment.nvim',
  opts = {}, -- add any options here
  lazy = false,
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "VeryLazy",
    },
  },
}

function M.config()
  vim.g.skip_ts_context_commentstring_module = true
  ---@diagnostic disable: missing-fields
  require("ts_context_commentstring").setup {
    enable_autocmd = false,
  }

  require("Comment").setup {
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  }

  require('Comment').setup()
end

-- keymaps
-- `gc[count]{motion}` - (Op-pending) go current comment
-- `gb[count]{motion}` - (Op-pending) go block comment
-- `gco` - Insert comment to the next line and enters INSERT mode
-- `gcO` - Insert comment to the previous line and enters INSERT mode
-- `gcA` - Insert comment to end of the current line and enters INSERT mode
-- supports treesitter textobjects eg. gcaf go comment around function

return M
