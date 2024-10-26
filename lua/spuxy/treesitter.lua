local M = {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
}

function M.config()
	require("nvim-treesitter.configs").setup({
		ignore_install = {},
		auto_install = true,
		sync_install = false,
    autopairs = { enable = true },
		ensure_installed = {
			"lua",
			"markdown",
			"markdown_inline",
			"bash",
			"python",
			"go",
		},
		highlight = { enable = true },
		indent = { 
      enable = true,
      disable = { "yaml" },
    },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<leader>ss",
				node_incremental = "<leader>si",
				scope_incremental = "<leader>sc",
				node_decremental = "<leader>sd",
			},
		},
	})
end

return M
