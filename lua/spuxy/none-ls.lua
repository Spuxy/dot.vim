local M = {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  }
}

function M.config()
  local null_ls = require "null-ls"

  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup {
    debug = false,
    sources = {
      formatting.stylua,
      formatting.prettier,
      formatting.black,
      -- formatting.prettier.with {
      --   extra_filetypes = { "toml" },
      --   -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
      -- },
      -- formatting.eslint,
      -- null_ls.builtins.diagnostics.flake8,
      -- diagnostics.flake8,


      null_ls.builtins.code_actions.refactoring,
      null_ls.builtins.code_actions.impl,
      null_ls.builtins.completion.spell,

      -- Golang + Python
      null_ls.builtins.diagnostics.semgrep,

      -- Golang
      null_ls.builtins.diagnostics.staticcheck,
      null_ls.builtins.diagnostics.revive,
      null_ls.builtins.diagnostics.golangci_lint,
      null_ls.builtins.formatting.goimports,
      null_ls.builtins.formatting.gofmt,
      null_ls.builtins.code_actions.gomodifytags,


      -- Shells (SH, BASH, ZSH)
      null_ls.builtins.diagnostics.zsh,
      null_ls.builtins.formatting.shellharden,
      null_ls.builtins.formatting.shfmt,

      --  Configuration files (PUPPET, HCL, YAML, JSON)
      null_ls.builtins.diagnostics.yamllint,
      null_ls.builtins.formatting.puppet_lint,


      -- .env
      null_ls.builtins.diagnostics.dotenv_linter,

      -- HTML
      null_ls.builtins.diagnostics.djlint,
      null_ls.builtins.formatting.prettier, -- its for YAML, JSON, HTML, MD, CSS

      -- Markdown
      null_ls.builtins.formatting.textlint,
      null_ls.builtins.formatting.mdformat,
      null_ls.builtins.formatting.markdownlint,
      null_ls.builtins.diagnostics.write_good
    },
  }
end

return M
