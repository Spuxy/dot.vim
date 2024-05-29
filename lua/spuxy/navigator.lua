local M = {
  "ray-x/navigator.lua",
  requires = {
    { "ray-x/guihua.lua",     run = "cd lua/fzy && make" },
    { "neovim/nvim-lspconfig" },
  },
}

function M.config()
  require("navigator").setup({})
end

return M
