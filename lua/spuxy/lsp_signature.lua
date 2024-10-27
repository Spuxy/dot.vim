local M = {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
	opts = {
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		handler_opts = {
			border = "rounded", -- or "single" or "double"
		},
		floating_window = true, -- Show popup window for function signature
		hint_enable = true, -- Disable if you don't want virtual text hint
		hint_prefix = "🐍 ", -- A fun prefix for virtual text
		hi_parameter = "Search", -- Highlight current parameter
		select_signature_key = "Tab",
	},
	config = function(_, opts)
		require("lsp_signature").setup(opts)
	end,
}

return M
