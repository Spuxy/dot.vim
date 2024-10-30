local M = {
	"ray-x/navigator.lua",
	requires = {
		{ "ray-x/guihua.lua", run = "cd lua/fzy && make" },
		{ "neovim/nvim-lspconfig" },
	},
	config = function()
		require("navigator").setup({
			keymaps = {
				{
					key = "<Leader>lr",
					func = require("navigator.rename").rename,
					desc = "rename",
				},
			},
		})
	end,
}

return M
