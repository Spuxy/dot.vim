local M = {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons'
}

function M.config()
    require("bufferline").setup()

    local wk = require "which-key"
    wk.register {
      ["<leader>bb"] = { "<cmd>BufferLinePick<cr>", "Jump" },
      ["<leader>bf"] = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
      ["<leader>bj"] = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
      ["<leader>bk"] = { "<cmd>BufferLineCycleNext<cr>", "Next" },
      ["<leader>bw"] = { "<cmd>noautocmd w<cr>", "Save without formatting (noautocmd)" },
      -- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
      ["<leader>be"] = { "<cmd>BufferLinePickClose<cr>", "Pick which buffer to close" },
      ["<leader>bh"] = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
      ["<leader>bl"] = { "<cmd>BufferLineCloseRight<cr>", "Close all to the right" },
      ["<leader>bD"] = { "<cmd>BufferLineSortByDirectory<cr>", "Sort by directory" },
      ["<leader>bL"] = { "<cmd>BufferLineSortByExtension<cr>", "Sort by language" },
    }
end

return M
