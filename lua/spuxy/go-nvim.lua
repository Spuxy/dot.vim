local M = {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}

function M.config()
  require("go").setup({
    lsp_keymaps = true,
    lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
    verbose = false,  -- output loginf in messages
  })
  require("go.format").goimports()

  -- local whichkey = require("which-key")
  -- whichkey.register {
  --   ["<leader>lgfs"] = { "<cmd>GoFillStruct<cr>", "Resume last search" },
  -- }
end

return M
