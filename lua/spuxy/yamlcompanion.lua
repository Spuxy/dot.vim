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
			{
				name = "GitHub Actions",
				uri = "https://json.schemastore.org/github-workflow.json",
			},
			{
				name = "Docker Compose",
				uri = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json",
			},
			{
				name = "Helm Chart.yaml",
				uri = "https://json.schemastore.org/chart.json",
			},
			{
				name = "Helm Values",
				uri = "https://json.schemastore.org/helmfile.json",
			},
			{
				name = "ArgoCD Application",
				uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json",
			},
			{
				name = "Ansible Playbook",
				uri = "https://raw.githubusercontent.com/ansible/schemas/main/f/ansible-playbook.json",
			},
			{
				name = "GitLab CI",
				uri = "https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json",
			},
		},
	})
  vim.lsp.enable("yamlls")
  vim.lsp.config("yamlls", cfg)
end

return M
