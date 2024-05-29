local M = {
	"s1n7ax/nvim-window-picker",
	name = "window-picker",
	event = "VeryLazy",
	version = "2.*",
	config = function()
		require("window-picker").setup()
	end,
}

function M.config()
	require("window-picker").setup({})
end

return M
