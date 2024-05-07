local M = {
  'nvimdev/lspsaga.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons'      -- optional
  }
}

function M.config()
  require('lspsaga').setup({
    symbols_in_winbar = { enable = true },
    finder = {
      keys = {
        shuttle = "o",
        toggle_or_open = "<CR>",
      },
      right_width = 0.7
    },
    implement = {
      enable = true,
      sign = true,
      virtual_text = true,
      priority = 100,
    },
    hover = {
      open_link = "<CR>"
    }
  })
end

return M
