local M = {
	"folke/which-key.nvim",
}

function M.config()
	local mappings = {
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
		l = {
			name = "LSP",
			-- a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
			a = { "<cmd>:Lspsaga code_action<cr>", "Code Action" },
			A = { "<cmd>:Lspsaga code_action<cr>", "Code Action" },
			d = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer Diagnostics (Trouble)" },
			w = { "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics (Trouble)" },
			f = {
				"<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
				"Format",
			},
			i = { "<cmd>LspInfo<cr>", "Info" },
			-- I = { "<cmd>Mason<cr>", "Mason Info" },
			I = { "<cmd>lua require('spuxy.lspconfig').toggle_inlay_hints()<cr>", "Hints" },
			j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
			k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
			l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
			q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
			r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
			S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
			e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
			h = { "<cmd>:Lspsaga hover_doc<cr>", "Hover Doc" },
			H = { "<cmd>:Lspsaga hover_doc ++keep<cr>", "Hover Doc + Keep" },
			s = { "<cmd>:Lspsaga signature_help<cr>", "Signature" },
			O = { "<cmd>Telescope lsp_document_symbols<cr>", "Workspace Symbols" },
			o = { "<cmd>:Lspsaga outline<cr>", "Outline Symbols" },
			p = {
				name = "Peek",
				p = { "<cmd>:Lspsaga peek_definition<cr>", "Preview" },
				d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", "Definition" },
				f = { ":Lspsaga finder<CR>", "Finder" },
				-- i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", "Implementation" },
			},
			g = {
				name = "Go",
				f = {
					name = "fill",
					s = { "<cmd>:GoFillStruct<cr>", "Struct" },
					e = { "<cmd>:GoFillErr<cr>", "Errors" },
				},
			},
			y = { "<cmd>:Telescope yaml_schema<cr>", "+ Yaml Schema store" },
		},
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
	}

	local which_key = require("which-key")
	which_key.setup({
		preset = "modern",
		disable = {
			buftypes = {},
			filetypes = { "TelescopePrompt" },
		},
	})

	local opts = {
		mode = "n", -- NORMAL mode
		prefix = "<leader>",
	}

	which_key.register(mappings, opts)
end

return M
