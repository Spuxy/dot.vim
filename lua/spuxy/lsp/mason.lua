local defaults = require("spuxy.defaults.tools")
local utils = require("spuxy.core.functions")
local M = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim"
	},
}

function M.config()
	require("mason").setup({
		ui = {
			border = "rounded",
		},
	})

	utils.mason_install(defaults.linters)
	utils.mason_install(defaults.formatters)

	require("mason-lspconfig").setup({
		ensure_installed = defaults.lsp_servers,
	})
end

return M
