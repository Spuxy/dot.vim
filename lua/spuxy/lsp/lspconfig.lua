local icons = require("spuxy.core.icons")

local go_settings     = require("spuxy.lsp.go.settings")
local lua_settings    = require("spuxy.lsp.lua.settings")
local rust_settings   = require("spuxy.lsp.rust.settings")
local c_settings      = require("spuxy.lsp.c.settings")
local python_settings = require("spuxy.lsp.python.settings")
local bash_settings   = require("spuxy.lsp.sh.settings")
local puppet_settings = require("spuxy.lsp.puppet.settings")
local ruby_settings   = require("spuxy.lsp.ruby.settings")
-- yaml settings are built inside config() to ensure schemastore.nvim is loaded first

local M = {
  "neovim/nvim-lspconfig",
  dependencies = { "hrsh7th/cmp-nvim-lsp", "b0o/schemastore.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    servers = {
      bashls = bash_settings,
      jsonls = {},
      dockerls = {},
      gopls = go_settings,
      harper_ls = {
        settings = {
          ["harper-ls"] = {
            linters = {
              SentenceCapitalization = false,
              SpellCheck = false,
            },
          },
        },
      },
      lua_ls = lua_settings,
      clangd = c_settings,
      marksman = {},
      pyright = python_settings,
      rust_analyzer = rust_settings,
      templ = {},
      terraformls = {
        filetypes = { "terraform", "terraform-vars", "tf" },
      },
      tinymist = {},
      ts_ls = {},
      -- yamlls built in config() below
      puppet = puppet_settings,
      ruby_lsp = ruby_settings,
    },
  },
  config = function(_, opts)
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
          [vim.diagnostic.severity.WARN]  = icons.diagnostics.Warning,
          [vim.diagnostic.severity.HINT]  = icons.diagnostics.Hint,
          [vim.diagnostic.severity.INFO]  = icons.diagnostics.Information,
        },
      },
      virtual_text = false,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        -- Attach navic if available
        local navic_ok, navic = pcall(require, "nvim-navic")
        if navic_ok then
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentSymbolProvider then
            navic.attach(client, event.buf)
          end
        end

        -- Setup buffer-local keymaps
        require("spuxy.lsp.keymaps").setup(event.buf)

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Highlight references of word under cursor
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })
          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
            end,
          })
        end
      end,
    })

    -- Build yamlls settings here so schemastore.nvim (a dependency) is guaranteed loaded
    opts.servers.yamlls = require("spuxy.lsp.yaml.settings")

    -- Content-based schema detection (apiVersion → schema URL → yamlls notify)
    require("spuxy.lsp.yaml.detect").setup()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if ok then
      capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())
    end

    for server, server_opts in pairs(opts.servers) do
      server_opts = vim.tbl_deep_extend("force", {}, server_opts, {
        capabilities = vim.tbl_deep_extend("force", {}, capabilities, server_opts.capabilities or {}),
      })
      vim.lsp.config(server, server_opts)
      vim.lsp.enable(server)
    end
  end,
}

return M
