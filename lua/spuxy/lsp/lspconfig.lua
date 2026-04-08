local defaults = require("spuxy.defaults.tools")
local icons = require("spuxy.core.icons")

local go_settings = require("spuxy.lsp.go.settings")
local lua_settings = require("spuxy.lsp.lua.settings")
local yaml_settings = require("spuxy.lsp.yaml.settings")
local rust_settings = require("spuxy.lsp.rust.settings")
local c_settings = require("spuxy.lsp.c.settings")
local python_settings = require("spuxy.lsp.python.settings")
local bash_settings = require("spuxy.lsp.sh.settings")

local M = {
  "neovim/nvim-lspconfig",
  dependencies = { 'saghen/blink.cmp' },
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    servers = {
      bashls = {
        settings = bash_settings,
      },
      jsonls = {},
      dockerls = {},
      gopls = {
        settings = go_settings,
      },
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
      lua_ls = {
        settings = lua_settings,
      },
      clangd = {
        settings = c_settings,
      },
      marksman = {},
      pyright = python_settings,
      rust_analyzer = {
        settings = rust_settings,
      },
      templ = {},
      terraformls = {
        filetypes = { "terraform", "terraform-vars", "tf" },
      },
      tinymist = {},
      ts_ls = {},
      yamlls = {
        settings = yaml_settings,
      },
    },
  },
  config = function(_, opts)
    local default_diagnostic_config = {
      signs = {
        active = true,
        values = {
          { name = "DiagnosticSignError", text = icons.diagnostics.Error },
          { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
          { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
          { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
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
        source = "always",
        header = "",
        prefix = "",
      },
    }
    vim.diagnostic.config(default_diagnostic_config)

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

        -- TODO: Only works if LSP is available and feature is supported.
        -- However, some do not support it and I want to see the color or I have no LSP installed.
        -- if client and client:supports_method("textDocument/documentColor") then
        --   vim.lsp.document_color.enable(true, event.buf)
        -- end

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
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
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
            end,
          })
        end
      end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
      for server, server_opts in pairs(opts.servers) do
        server_opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server_opts.capabilities or {})
        vim.lsp.config(server, server_opts)
        vim.lsp.enable(server)
      end
  end,
}

-- local function lsp_keymaps(bufnr)
--   local opts = {
--     noremap = true,
--     silent = true,
--     -- inlay_hints = {
--     -- 	enabled = true,
--     -- },
--   }
--   local keymap = vim.api.nvim_buf_set_keymap
--   keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
--   keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
--   keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
--   keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
--   keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
--   keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
-- end

-- M.on_attach = function(client, bufnr)
--   lsp_keymaps(bufnr)
--   if client.supports_method("textDocument/inlayHint") then
--     vim.lsp.inlay_hint.enable(true)
--   end
-- end

-- function M.common_capabilities()
--   local capabilities = vim.lsp.protocol.make_client_capabilities()
--   capabilities.textDocument.completion.completionItem.snippetSupport = true
--   return capabilities
-- end

-- M.toggle_inlay_hints = function()
--   -- local bufnr = vim.api.nvim_get_current_buf()
--   -- vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
--   vim.lsp.inlay_hint.enable(true)
-- end

-- function M.config()
--   require("spuxy.lsp.mappings")
--   -- require("spuxy.lsp.go.settings")
--   -- require("spuxy.lsp.yaml.settings")
--   -- require("spuxy.lsp.lua.settings")
--   -- require("spuxy.lsp.json.settings")
--   -- require("spuxy.lsp.c.settings")

--   -- local lspconfig = require("lspconfig")


--   for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
--     vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
--   end

--   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
--   vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
--   require("lspconfig.ui.windows").default_options.border = "rounded"

--   for _, server in pairs(defaults.lsp_servers) do
--     local opts = {
--       on_attach = M.on_attach,
--       capabilities = M.common_capabilities(),
--     }

--     -- local require_ok, settings = pcall(require, "spuxy.lspsettings." .. server)
--     local require_ok, settings = pcall(require, "spuxy.lsp." .. server .. ".settings")
--     if require_ok then
--       opts = vim.tbl_deep_extend("force", settings, opts)
--     end

--     -- if server == "lua_ls" then
--     --   require("lazydev.nvim").setup({})
--     -- end

--     -- lspconfig[server].setup(opts)
--     -- vim.lsp.enable(server)
--     -- vim.lsp.config(server, opts)
--   end
-- end

return M
