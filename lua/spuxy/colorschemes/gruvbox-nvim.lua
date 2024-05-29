local M = {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = true,
}

function M.config()
	vim.o.background = "light"
	vim.cmd.colorscheme("gruvbox")
	require("gruvbox").setup({
		transparent_mode = true,
	})
end

return M
