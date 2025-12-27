local utils = require("spuxy.core.functions")
local tools = require("spuxy.defaults.tools")

local M = {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile", "InsertLeave" },
  opts = {
    format_on_save = function()
      if vim.g.disable_autoformat then
        return
      end
      return { async = false, timeout_ms = 500, lsp_fallback = false }
    end,
    formatters_by_ft = tools.formatters,
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" }, -- 2 spaces instead of tab
      },
      stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" }, -- 2 spaces instead of tab
      },
      yamlfmt = {
        prepend_args = { "-formatter", "indent=2,include_document_start=true,retain_line_breaks_single=true" },
      },
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
    vim.api.nvim_create_user_command("ToggleAutoformat", function()
      -- vim.g.disable_autoformat = vim.g.disable_autoformat == false and true or false
      utils.notify(
        string.format("Toggling autoformat %s", vim.g.disable_autoformat),
        vim.log.levels.INFO,
        "conform.nvim"
      )

      if vim.g.disable_autoformat then
        vim.g.disable_autoformat = false
      else
        vim.g.disable_autoformat = true
      end
    end, { desc = "Toggling autoformat" })
    require("spuxy.defaults.mappings.conform")
  end,
}

return M
