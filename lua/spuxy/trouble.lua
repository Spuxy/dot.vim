local M = {
	"folke/trouble.nvim",
	cmd = "Trouble",
	opts = {
		auto_preview = false,
		auto_close = true,
		focus = true,
	},
	keys = {
		{ "<leader>mx", "", desc = "Trouble" },
		{ "<leader>mxq", "<cmd>Trouble qflist toggle<cr>", desc = "Toggle" },
		{ "<leader>mxl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
		{ "<leader>mxj", function() require("trouble").next({ skip_groups = true, jump = true }) end, desc = "Next" },
		{ "<leader>mxk", function() require("trouble").prev({ skip_groups = true, jump = true }) end, desc = "Prev" },
	},
	config = function(_, opts)
		require("trouble").setup(opts)
	end,
}

return M
