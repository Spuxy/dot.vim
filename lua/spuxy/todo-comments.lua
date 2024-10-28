local M = {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "VeryLazy" },
	opts = {},
	keys = {
		{ "<leader>mt", "", desc = "Todo comments" },
		{ "<leader>mtt", "<cmd>TodoTrouble<cr>", desc = "Terminal" },
		{ "<leader>mtf", "<cmd>TodoTelescope<cr>", desc = "Telescope" },
	},
	config = function()
		require("todo-comments").setup()
	end,
}

return M
