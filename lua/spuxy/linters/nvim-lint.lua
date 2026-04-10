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

    -- Neovim 0.11 rejects diagnostics with end_lnum/end_col = -1 (no end pos).
    -- Clamp to the start position so the diagnostic is still shown.
    local orig_set = vim.diagnostic.set
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.diagnostic.set = function(ns, bufnr, diagnostics, diag_opts)
      for _, d in ipairs(diagnostics) do
        if d.end_lnum == nil or d.end_lnum < 0 then d.end_lnum = d.lnum end
        if d.end_col == nil or d.end_col < 0 then d.end_col = d.col end
      end
      orig_set(ns, bufnr, diagnostics, diag_opts)
    end

    local lint_augroup = vim.api.nvim_create_augroup("linting", { clear = true })
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    local disabled_fts = {}
    vim.api.nvim_create_user_command("ToggleLinting", function()
      local ft = vim.filetype.match({ buf = 0 }) or ""
      if disabled_fts[ft] then
        disabled_fts[ft] = false
        lint.linters_by_ft[ft] = defaults.linters[ft] or {}
        lint.try_lint()
        utils.notify("Linting enabled for " .. ft, vim.log.levels.INFO, "nvim-lint")
      else
        disabled_fts[ft] = true
        lint.linters_by_ft[ft] = {}
        vim.diagnostic.reset(nil, 0)
        utils.notify("Linting disabled for " .. ft, vim.log.levels.INFO, "nvim-lint")
      end
    end, { desc = "Toggle linting for current filetype" })
    vim.keymap.set("n", "<leader>TL", "<cmd>ToggleLinting<cr>", { desc = "Linting" })
  end,
}

return M
