local wk = require("which-key")

wk.add({
  { "<leader>l", group = "LSP" },
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

  { "<leader>ld", group = "Debugging"},
  { "<leader>ldi", "<cmd>LspInfo<cr>", desc = "Info" },
  { "<leader>ldI", "<cmd>Mason<cr>", desc = "Mason Info" },

  { "<leader>lp", group = "Peek" },
  { "<leader>lpp", "<cmd>:Lspsaga peek_definition<cr>", desc = "Preview" },
  { "<leader>lpd", function() require('lvim.lsp.peek').Peek('definition') end, desc = "Definition" },
  { "<leader>lpf", ":Lspsaga finder<CR>", desc = "Finder" },
  -- { "<leader>lpi", "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", desc = "Implementation" },

  { "<leader>lg", group = "Go" },
  { "<leader>lgf", group = "fill" },
  { "<leader>lgfs", "<cmd>:GoFillStruct<cr>", desc = "Struct" },
  { "<leader>lgfe", "<cmd>:GoFillErr<cr>", desc = "Errors" },
})

-- require("which-key").register({
--     l = {
--         a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action", mode = "v" },
--         A = { "<cmd>:Lspsaga code_action<cr>", "Code Action" },
--         d = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer Diagnostics (Trouble)" },
--         w = { "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics (Trouble)" },
--         f = {
--             "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
--             "Format",
--         },
--         i = { "<cmd>LspInfo<cr>", "Info" },
--         -- I = { "<cmd>Mason<cr>", "Mason Info" },
--         I = { "<cmd>lua require('spuxy.lspconfig').toggle_inlay_hints()<cr>", "Hints" },
--         j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
--         k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
--         l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
--         q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
--         r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
--         S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
--         e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
--         h = { "<cmd>:Lspsaga hover_doc<cr>", "Hover Doc" },
--         H = { "<cmd>:Lspsaga hover_doc ++keep<cr>", "Hover Doc + Keep" },
--         s = { "<cmd>:lua vim.lsp.buf.signature_help()<cr>", "Signature" },
--         O = { "<cmd>Telescope lsp_document_symbols<cr>", "Workspace Symbols" },
--         o = { "<cmd>:Lspsaga outline<cr>", "Outline Symbols" },
--         p = {
--             name = "Peek",
--             p = { "<cmd>:Lspsaga peek_definition<cr>", "Preview" },
--             d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", "Definition" },
--             f = { ":Lspsaga finder<CR>", "Finder" },
--             -- i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", "Implementation" },
--         },
--         g = {
--             name = "Go",
--             f = {
--                 name = "fill",
--                 s = { "<cmd>:GoFillStruct<cr>", "Struct" },
--                 e = { "<cmd>:GoFillErr<cr>", "Errors" },
--             },
--         },
--         y = { "<cmd>:Telescope yaml_schema<cr>", "+ Yaml Schema store" },
--     },
--     { prefix = "<leader>" },
-- })
-- local M = {}
-- function M.config()
--   require("which-key").register({
--     l = {
--         a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action", mode = "v" },
--         A = { "<cmd>:Lspsaga code_action<cr>", "Code Action" },
--         d = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer Diagnostics (Trouble)" },
--         w = { "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics (Trouble)" },
--         f = {
--             "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
--             "Format",
--         },
--         i = { "<cmd>LspInfo<cr>", "Info" },
--         -- I = { "<cmd>Mason<cr>", "Mason Info" },
--         I = { "<cmd>lua require('spuxy.lspconfig').toggle_inlay_hints()<cr>", "Hints" },
--         j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
--         k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
--         l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
--         q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
--         r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
--         S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
--         e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
--         h = { "<cmd>:Lspsaga hover_doc<cr>", "Hover Doc" },
--         H = { "<cmd>:Lspsaga hover_doc ++keep<cr>", "Hover Doc + Keep" },
--         s = { "<cmd>:lua vim.lsp.buf.signature_help()<cr>", "Signature" },
--         O = { "<cmd>Telescope lsp_document_symbols<cr>", "Workspace Symbols" },
--         o = { "<cmd>:Lspsaga outline<cr>", "Outline Symbols" },
--         p = {
--             name = "Peek",
--             p = { "<cmd>:Lspsaga peek_definition<cr>", "Preview" },
--             d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", "Definition" },
--             f = { ":Lspsaga finder<CR>", "Finder" },
--             -- i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", "Implementation" },
--         },
--         g = {
--             name = "Go",
--             f = {
--                 name = "fill",
--                 s = { "<cmd>:GoFillStruct<cr>", "Struct" },
--                 e = { "<cmd>:GoFillErr<cr>", "Errors" },
--             },
--         },
--         y = { "<cmd>:Telescope yaml_schema<cr>", "+ Yaml Schema store" },
--     },
--   }, { mode = "n", prefix = "<leader>" })
-- end
