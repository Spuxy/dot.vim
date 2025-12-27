local defaults = require("spuxy.defaults.tools")

local M = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim"
	},
  config = function ()
    require("mason").setup({
      ui = {
        border = "rounded",
      },
    })

    -- Flatten linters and formatters into single arrays
    local function flatten(t)
      local result = {}
      for _, v in pairs(t) do
        if type(v) == "table" then
          for _, item in ipairs(v) do
            table.insert(result, item)
          end
        else
          table.insert(result, v)
        end
      end
      return result
    end

    local all_formatters = flatten(defaults.formatters)
    local all_linters = flatten(defaults.linters)

    -- Combine all tools
    local all_tools = vim.list_extend(
      vim.list_extend(vim.deepcopy(defaults.lsp_servers), all_formatters),
      all_linters
    )

    require("mason-tool-installer").setup({
      ensure_installed = all_tools,
      auto_update = false,
      run_on_start = true,
    })

    require("mason-lspconfig").setup({
      ensure_installed = defaults.lsp_servers,
    })
  end
}

return M
