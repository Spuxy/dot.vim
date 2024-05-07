local M = {
	"someone-stole-my-name/yaml-companion.nvim",
	dependencies = {
		{ "neovim/nvim-lspconfig" },
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope.nvim" },
	},
}

function M.config()
	require("telescope").load_extension("yaml_schema")
	local cfg = require("yaml-companion").setup({
		schemas = {
			{
				name = "Kubernetes 1.30.0",
				uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.0-standalone-strict/all.json",
			},
		},
	})
	require("lspconfig")["yamlls"].setup(cfg)
end

return M
