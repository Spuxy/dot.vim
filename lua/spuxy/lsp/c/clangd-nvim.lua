-- https://github.com/p00f/clangd_extensions.nvim
local M = {
	"p00f/clangd_extensions.nvim",
}

M.config = function()
	require("clangd_extensions").setup()
end

return M
