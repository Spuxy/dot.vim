local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		disable = {
			buftypes = {},
			filetypes = { "TelescopePrompt" },
		},
		layout = {
			width = { min = 5, max = 50 },
			spacing = 10,
			align = "center",
		},
	},
	config = function(_, opts)
		require("which-key").setup(opts)
		require("which-key").register({
			q = { "<cmd>confirm q<CR>", "Quit" },
			e = { "<cmd>Lexplore <CR>", "Explore" },
			H = { "<cmd>nohlsearch<CR>", "NOHL" },
			[";"] = { "<cmd>tabnew | terminal<CR>", "Term" },
			v = { "<cmd>vsplit<CR>", "Vertical Split" },
			h = { "<cmd>split<CR>", "Horizontal Split" },
			y = { "<cmd>Telescope projects<CR>", "Projects" },
			b = { name = "Buffers" },
			d = { name = "Debug" },
			f = { name = "Find" },
			g = { name = "Git" },
			n = { name = "Todos" },
			p = { name = "Plugins" },
			t = { name = "Test" },
			a = {
				name = "Tab",
				n = { "<cmd>$tabnew<cr>", "New Empty Tab" },
				N = { "<cmd>tabnew %<cr>", "New Tab" },
				o = { "<cmd>tabonly<cr>", "Only" },
				h = { "<cmd>-tabmove<cr>", "Move Left" },
				l = { "<cmd>+tabmove<cr>", "Move Right" },
			},
			T = { name = "Treesitter" },
			m = { name = "Misc" },
			s = { name = "Search" },
		}, {
			mode = "n", -- NORMAL mode
			prefix = "<leader>",
		})
	end,
}

return M
