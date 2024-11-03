-- Tools that should be installed by Mason
-- LSPs that should be installed by Mason-lspconfig
return {
    lsp_servers = {
        -- html
        "cssls",
        "html",
        -- shells
        "bashls",
        -- containers
        "dockerls",
        -- declerative
        "jsonls",
        "helm_ls",
        "yamlls",
        "ansiblels",
        -- go
        "gopls",
        -- python
        "pyright",
        -- lua
        "lua_ls",
        -- rust
        "rust_analyzer",
        -- c
        "clangd",
    },

    formatters = {
        go = { "goimports", "gofmt" },
            rust = { "rustfmt" },
            javascript = { "prettier" },
            json = { "prettier" },
            lua = { "stylua" },
            markdown = { "prettier" },
            python = { "isort", "ruff_format", "black" },
            sh = { "shfmt" },
            yaml = { "yamlfmt" },
            rst = { "rstfmt"},
    },

    linters = {
        dockerfile = { "hadolint" },
        go = { "revive", "golangcilint" },
        lua = { "selene" },
        sh = { "shellcheck" },
        yaml = { "yamllint" },
        puppet = { "puppet-lint"},
        python = { "pylint", "pydocstyle", "pycodestyle" },
        markdown = {'write-good', "markdownlint"}
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
        "codelldb"
    },
} 