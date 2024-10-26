local M = {
	"mrjones2014/smart-splits.nvim",
	lazy = true,
}

function M.config()
	require("smart-splits").setup({})
end

return M
