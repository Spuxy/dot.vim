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
        -- go
        "gospel",
        "golangci-lint",
        "staticcheck",
        "revive",

        -- markdown
        "textlint",
        "markdownlint",
        "write-good",

        -- git
        "actionlint",

        -- declerative
        "ansible-lint",
        "jsonlint",
        "yamllint",

        -- c
        "cpplint",
        "checkmake",
        "cmakelint",

        -- html
        "djlint",

        -- containers
        "hadolint",
        "snyk",
        "sonarlint-language-server",

        -- python
        "flake8",
        "pylint",
        "ruff",
        "pydocstyle",
        "pyflakes",

        -- shells
        "shellcheck",

        -- lua
        "luacheck",
        "selene",
    },

    debuggers = {
        "python",
        "delve",
        "cppdbg",
        "bash",
        "codelldb"
    },
} 