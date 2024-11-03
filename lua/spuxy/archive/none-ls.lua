local M = {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
function M.config()
  local null_ls = require("null-ls")
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  null_ls.setup({
    debug = false,
    sources = {
      formatting.stylua,
      formatting.prettier,
      formatting.black,
      -- formatting.eslint,
      null_ls.builtins.code_actions.refactoring,
      null_ls.builtins.code_actions.impl,
      null_ls.builtins.completion.spell,
      -- python
      null_ls.builtins.diagnostics.flake8,
      null_ls.builtins.diagnostics.mypy,
      null_ls.builtins.diagnostics.pylint,
      null_ls.builtins.formatting.isort,

      -- Golang
      null_ls.builtins.diagnostics.staticcheck,
      null_ls.builtins.diagnostics.revive,
      null_ls.builtins.diagnostics.golangci_lint,
      null_ls.builtins.formatting.goimports,
      null_ls.builtins.formatting.golines,
      null_ls.builtins.formatting.gofmt,
      null_ls.builtins.code_actions.gomodifytags,

      -- Shells (SH, BASH, ZSH)
      null_ls.builtins.diagnostics.zsh,
      null_ls.builtins.formatting.shellharden,
      null_ls.builtins.formatting.shfmt,

      --  Configuration files (PUPPET, HCL, YAML, JSON)
      null_ls.builtins.diagnostics.yamllint,
      null_ls.builtins.diagnostics.ansiblelint,
      null_ls.builtins.diagnostics.actionlint,
      null_ls.builtins.formatting.yamlfix,
      null_ls.builtins.formatting.yamlfmt,
      null_ls.builtins.formatting.biome,
      null_ls.builtins.formatting.jsonlint,
      null_ls.builtins.formatting.puppet_lint,

      -- .env
      null_ls.builtins.diagnostics.dotenv_linter,

      -- HTML
      null_ls.builtins.diagnostics.djlint,
      null_ls.builtins.formatting.prettier,
      -- Markdown
      null_ls.builtins.formatting.textlint,
      null_ls.builtins.formatting.mdformat,
      null_ls.builtins.formatting.markdownlint,
      null_ls.builtins.diagnostics.write_good,
    },
  })
end

return M
