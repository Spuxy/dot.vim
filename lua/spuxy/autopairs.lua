local M = {
	"windwp/nvim-autopairs",
	opts = {
		enable_check_bracket_line = false, -- Don't add pairs if it already has a close pair in the same line
		check_ts = true,
		disable_filetype = { "TelescopePrompt", "spectre_panel" },
	},
}

return M
