local M = {}

-- Buffer-local LSP keymaps setup function (called on LspAttach)
function M.setup(bufnr)
  local wk = require("which-key")
  
  wk.add({
    buffer = bufnr,

    -- Native LSP commands
    { "<leader>lf", function() vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end}) end, desc = "Format" },
    { "<leader>lr", vim.lsp.buf.rename, desc = "Rename" },
    { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "x" } },
    { "<leader>lD", vim.lsp.buf.declaration, desc = "Declaration" },
    { "<leader>ll", vim.lsp.codelens.run, desc = "CodeLens Action" },
    { "<leader>lq", vim.diagnostic.setloclist, desc = "Quickfix" },

    -- Lspsaga actions
    { "<leader>lsa", "<cmd>:Lspsaga code_action<cr>", desc = "Code Action (Saga)" },
    { "<leader>lh", "<cmd>:Lspsaga hover_doc<cr>", desc = "Hover Doc" },
    { "<leader>lH", "<cmd>:Lspsaga hover_doc ++keep<cr>", desc = "Hover Doc + Keep" },
    { "<leader>lo", "<cmd>:Lspsaga outline<cr>", desc = "Outline Symbols" },
    { "<leader>lpp", "<cmd>:Lspsaga peek_definition<cr>", desc = "Preview Definition" },
    { "<leader>lpd", vim.lsp.buf.definition, desc = "Peek Definition" },
    { "<leader>lpf", ":Lspsaga finder<CR>", desc = "Finder" },

    -- Trouble diagnostics
    { "<leader>ld", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>lw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },

    -- Telescope LSP
    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
    { "<leader>lO", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
    { "<leader>le", "<cmd>Telescope quickfix<cr>", desc = "Quickfix" },

    -- Diagnostics navigation
    { "<leader>lj", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
    { "<leader>lk", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },

    -- Goto mappings
    { "gH", vim.lsp.buf.hover, desc = "Hover" },
    { "gD", vim.lsp.buf.declaration, desc = "Declaration" },
    { "gd", vim.lsp.buf.definition, desc = "Definition" },
    { "gI", vim.lsp.buf.implementation, desc = "Implementation" },
    { "gr", vim.lsp.buf.references, desc = "References" },
    { "gl", vim.diagnostic.open_float, desc = "Open Diagnostic Float" },
    { "gs", vim.lsp.buf.signature_help, desc = "Signature Help" },

  })

  -- Go-specific keymaps (only when gopls is attached)
  Snacks.keymap.set("n", "<leader>lgfs", "<cmd>GoFillStruct<cr>", { lsp = { name = "gopls" }, desc = "Fill Struct" })
  Snacks.keymap.set("n", "<leader>lgfe", "<cmd>GoFillErr<cr>",    { lsp = { name = "gopls" }, desc = "Fill Errors" })
end

return M
