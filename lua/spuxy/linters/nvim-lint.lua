-- local linters = require("spuxy.defaults.tools").linters

-- local M = {
--   "mfussenegger/nvim-lint",
--   event = { "BufWritePost", "BufReadPost", "InsertLeave" },
--   opts = {
--     linters_by_ft = linters,
--   },
--   config = function(_, opts)
--     local lint = require("lint")
--     lint.linters_by_ft = opts.linters_by_ft
--     local lint_augroup = vim.api.nvim_create_augroup("linting", { clear = true })
--     vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
--       group = lint_augroup,
--       callback = function()
--         lint.try_lint()
--       end,
--     })
--   end,
-- }

-- return M


local utils = require("spuxy.core.functions")
local defaults = require("spuxy.defaults.tools")
local M = {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = defaults.linters,
  },
  config = function(_, opts)
    local lint = require("lint")
    lint.linters_by_ft = opts.linters_by_ft
    local lint_augroup = vim.api.nvim_create_augroup("linting", { clear = true })
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
    vim.api.nvim_create_user_command("DisableLinting", function()
      utils.notify("Disable Linting", vim.log.levels.INFO, "nvim-lint")
      local ft = vim.filetype.match({ buf = 0 })
      require("lint").linters_by_ft[ft] = {}
      vim.diagnostic.hide()
    end, { desc = "Disable linting for current filetype" })
    vim.keymap.set("n", "<leader>lL", "<cmd>DisableLinting<cr>", { desc = "Toggle Linting" })
  end,
}

return M
