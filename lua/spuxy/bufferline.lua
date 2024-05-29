local M = {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
}

function M.config()
	require("bufferline").setup({
		options = {
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				local icon = level:match("error") and " " or " "
				return " " .. icon .. count
			end,
		},
	})

	require("which-key").register({
		["<leader>bb"] = { "<cmd>BufferLinePick<cr>", "Jump" },
		["<leader>bf"] = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
		["<leader>bj"] = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
		["<leader>bk"] = { "<cmd>BufferLineCycleNext<cr>", "Next" },
		["<leader>bp"] = { "<cmd>BufferLineTogglePin<cr>", "Pin" },
		["<leader>be"] = { "<cmd>BufferLinePickClose<cr>", "Pick which buffer to close" },
	})
end

return M
