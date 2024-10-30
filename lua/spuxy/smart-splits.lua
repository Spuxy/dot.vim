local M = {
	"mrjones2014/smart-splits.nvim",
	lazy = true,
	config = function(_, opts)
		require("smart-splits").setup(opts)
	end,
}

return M
