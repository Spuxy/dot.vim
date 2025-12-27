-- Tools that should be installed by Mason
-- LSPs that should be installed by Mason-lspconfig
return {
  lsp_servers = {
    "cssls",
    "html",
    "bashls",
    "dockerls",
    "jsonls",
    "helm_ls",
    "yamlls",
    "ansiblels",
    "gopls",
    "pyright",
    "lua_ls",
    "rust_analyzer",
    "clangd",
    "ltex-ls-plus",
    "puppet-editor-services"
  },

  formatters = {
    go = { "goimports", "gofumpt" },
    rust = { "rustfmt" },
    javascript = { "prettier" },
    json = { "prettier" },
    lua = { "stylua" },
    markdown = { "prettier" },
    python = { "isort", "ruff", "black" },
    sh = { "shfmt" },
    yaml = { "yamlfmt" },
  },

  linters = {
    dockerfile = { "hadolint" },
    -- go = { "revive", "golangci-lint" },
    go = { "revive" },
    lua = { "selene" },
    sh = { "shellcheck" },
    yaml = { "yamllint" },
    python = { "pylint" },
    markdown = { "write-good", "markdownlint", "markdownlint-cli2" },
    rst = { "rstcheck", "sphinx-lint" },
    rust = { "snyk", "bacon" }
  },

  treesitter = {
    "bash",
    "cmake",
    "css",
    "dockerfile",
    "go",
    "hcl",
    "html",
    "javascript",
    "json",
    "jsonc",
    "lua",
    "markdown",
    "markdown_inline",
    "query",
    "python",
    "regex",
    "toml",
    "vim",
    "yaml",
  },

  debuggers = {
    "python",
    "delve",
    "cppdbg",
    "bash",
    "codelldb",
  },
}
