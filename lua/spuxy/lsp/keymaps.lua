local M = {}

-- Buffer-local LSP keymaps setup function (called on LspAttach)
function M.setup(bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- Native LSP commands
  map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true, filter = function(c) return c.name ~= "typescript-tools" end }) end, "Format")
  map("n", "<leader>lr", vim.lsp.buf.rename,        "Rename")
  map({ "n", "x" }, "<leader>la", vim.lsp.buf.code_action, "Code Action")
  map("n", "<leader>lD", vim.lsp.buf.declaration,   "Declaration")
  map("n", "<leader>ll", vim.lsp.codelens.run,       "CodeLens Action")
  map("n", "<leader>lq", vim.diagnostic.setloclist,  "Quickfix")

  -- Lspsaga actions
  map("n", "<leader>lsa", "<cmd>Lspsaga code_action<cr>",    "Code Action (Saga)")
  map("n", "<leader>lh",  "<cmd>Lspsaga hover_doc<cr>",      "Hover Doc")
  map("n", "<leader>lH",  "<cmd>Lspsaga hover_doc ++keep<cr>","Hover Doc + Keep")
  map("n", "<leader>lo",  "<cmd>Lspsaga outline<cr>",         "Outline Symbols")
  map("n", "<leader>lpp", "<cmd>Lspsaga peek_definition<cr>", "Preview Definition")
  map("n", "<leader>lpd", vim.lsp.buf.definition,             "Peek Definition")
  map("n", "<leader>lpf", "<cmd>Lspsaga finder<cr>",          "Finder")

  -- Trouble diagnostics
  map("n", "<leader>ld", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer Diagnostics (Trouble)")
  map("n", "<leader>lw", "<cmd>Trouble diagnostics toggle<cr>",              "Diagnostics (Trouble)")

  -- Telescope LSP
  map("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols")
  map("n", "<leader>lO", "<cmd>Telescope lsp_document_symbols<cr>",          "Document Symbols")
  map("n", "<leader>le", "<cmd>Telescope quickfix<cr>",                       "Quickfix")

  -- Diagnostics navigation
  map("n", "<leader>lj", vim.diagnostic.goto_next, "Next Diagnostic")
  map("n", "<leader>lk", vim.diagnostic.goto_prev, "Prev Diagnostic")

  -- Goto mappings
  map("n", "gH", vim.lsp.buf.hover,            "Hover")
  map("n", "gD", vim.lsp.buf.declaration,      "Declaration")
  map("n", "gd", vim.lsp.buf.definition,       "Definition")
  map("n", "gI", vim.lsp.buf.implementation,   "Implementation")
  map("n", "gr", vim.lsp.buf.references,       "References")
  map("n", "gl", vim.diagnostic.open_float,    "Open Diagnostic Float")
  map("n", "gs", vim.lsp.buf.signature_help,   "Signature Help")

  -- Go-specific keymaps (only when gopls is attached)
  Snacks.keymap.set("n", "<leader>lgfs", "<cmd>GoFillStruct<cr>", { lsp = { name = "gopls" }, desc = "Fill Struct" })
  Snacks.keymap.set("n", "<leader>lgfe", "<cmd>GoFillErr<cr>",    { lsp = { name = "gopls" }, desc = "Fill Errors" })
end

return M
