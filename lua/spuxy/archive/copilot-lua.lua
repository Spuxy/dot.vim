local M = {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
  keys = {
    { "<leader>mac", "", desc = "Copilot" },
    { "<leader>mact", function () require('copilot.suggestion').toggle_auto_trigger() end, desc = "Copilot deattche" },
  },
	dependencies = {
		"zbirenbaum/copilot-cmp",
	},
  config = function ()
	require("copilot").setup({
		panel = {
			keymap = {
				jump_next = "<c-j>",
				jump_prev = "<c-k>",
				accept = "<c-l>",
				refresh = "r",
				open = "<M-CR>",
			},
		},
		suggestion = {
			enabled = true,
			auto_trigger = true,
			keymap = {
				accept = "<c-l>",
				next = "<c-j>",
				prev = "<c-k>",
				dismiss = "<c-h>",
			},
		},
		filetypes = {
			markdown = true,
			help = false,
			gitcommit = false,
			gitrebase = false,
			hgcommit = false,
			svn = false,
			cvs = false,
			["."] = false,
		},
		copilot_node_command = "node",
	})
	require("copilot_cmp").setup()
  end
}

return M
