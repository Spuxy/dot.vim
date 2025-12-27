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
  keys = {
    { "<leader>lsa", "<cmd>:Lspsaga code_action<cr>", desc = "Code Action" },
    { "<leader>ld", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>lw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    { "<leader>lI", "<cmd>lua require('spuxy.lsp.lspconfig').toggle_inlay_hints()<cr>", desc = "Hints" },
    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
    { "<leader>le", "<cmd>Telescope quickfix<cr>", desc = "Telescope Quickfix" },
    { "<leader>lh", "<cmd>:Lspsaga hover_doc<cr>", desc = "Hover Doc" },
    { "<leader>lH", "<cmd>:Lspsaga hover_doc ++keep<cr>", desc = "Hover Doc + Keep" },
    { "<leader>lO", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Workspace Symbols" },
    { "<leader>lo", "<cmd>:Lspsaga outline<cr>", desc = "Outline Symbols" },

    { "<leader>ldi", "<cmd>LspInfo<cr>", desc = "Info" },
    { "<leader>ldI", "<cmd>Mason<cr>", desc = "Mason Info" },

    { "<leader>lpp", "<cmd>:Lspsaga peek_definition<cr>", desc = "Preview" },
    { "<leader>lpd", function() require('lvim.lsp.peek').Peek('definition') end, desc = "Definition" },
    { "<leader>lpf", ":Lspsaga finder<CR>", desc = "Finder" },
    -- { "<leader>lpi", "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", desc = "Implementation" },

    { "<leader>lgfs", "<cmd>:GoFillStruct<cr>", desc = "Struct" },
    { "<leader>lgfe", "<cmd>:GoFillErr<cr>", desc = "Errors" },
  },
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
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
        end

        map("<leader>lf", function() vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})end, "Format")
        map("<leader>lh", vim.lsp.buf.hover, "Hover")
        map("<leader>lr", vim.lsp.buf.rename, "Rename")
        map("<leader>la", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
        map("<leader>lD", vim.lsp.buf.declaration, "Declaration")

        map("<leader>lj", vim.diagnostic.goto_next, "Next Diagnostic")
        map("<leader>lk", vim.diagnostic.goto_prev, "Prev Diagnostic")
        map("<leader>ll", vim.lsp.codelens.run, "CodeLens Action")
        map("<leader>lq", vim.diagnostic.setloclist, "Quickfix")

        map("gH", vim.lsp.buf.hover, "Hover")
        map("gD", vim.lsp.buf.declaration, "Declaration")
        map("gd", vim.lsp.buf.definition, "Definition")
        map("gI", vim.lsp.buf.implementation, "Implementation")
        map("gr", vim.lsp.buf.references, "References")
        map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
        map("gs", vim.lsp.buf.signature_help, "Show Signature Help")

        -- local opts = { buffer = bufnr, noremap = true, silent = true }
        -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
        -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
        -- vim.keymap.set("n", "<space>wl", function()
        --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, opts)
        -- vim.keymap.set("n", "<space>lD", vim.lsp.buf.type_definition, opts)
        -- vim.keymap.set("n", "<space>lr", vim.lsp.buf.rename, opts)
        -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        -- vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
        -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        -- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
        -- vim.keymap.set("n", "<space>li", "<cmd>LspInfo<CR>", opts)
        -- vim.keymap.set("n", "<space>lI", "<cmd>Mason<CR>", opts)

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
