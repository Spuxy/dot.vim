require("spuxy.core.keymaps")
require("spuxy.core.launch")
require("spuxy.core.options")
require("spuxy.core.functions")

-- MISC
spec("spuxy.alpha")
spec("spuxy.devicons")
spec("spuxy.breadcrumbs")
spec("spuxy.noice")
spec("spuxy.trouble")
spec("spuxy.treesj")
spec("spuxy.markdown")

-- COLORSCHEMES
-- spec("spuxy.colorschemes.gruvbox-nvim")
-- spec("spuxy.colorschemes.pywal-nvim")
-- spec("spuxy.colorschemes.flow")
spec("spuxy.colorschemes.neopywal-nvim")

-- MOVEMENTS
spec("spuxy.autopairs") -- own keymaps
spec("spuxy.comment") -- own keymaps
spec("spuxy.indentline")
spec("spuxy.bufferline") -- own keymaps
spec("spuxy.telescope")
spec("spuxy.whichkey")
spec("spuxy.surround") -- own keymaps
spec("spuxy.window-picker") -- own keymaps
spec("spuxy.spectre")

-- FILESYSTEM
spec("spuxy.neotree") -- own keymaps
spec("spuxy.lualine")

-- Projects manipulation
spec("spuxy.project")
spec("spuxy.harpoon")

-- LSP
spec("spuxy.navic")
spec("spuxy.cmp")
spec("spuxy.neodev")
spec("spuxy.lspconfig")
spec("spuxy.lsp.none-ls")
spec("spuxy.lsp.mason")
spec("spuxy.treesitter")
spec("spuxy.treesitter-textobjects")
spec("spuxy.yamlcompanion")
spec("spuxy.navigator")
spec("spuxy.symbol-usage")
spec("spuxy.luasnip")

-- GIT
spec("spuxy.gitsigns")
spec("spuxy.neogit")

-- UI
spec("spuxy.bqf")
spec("spuxy.lspsaga")
spec("spuxy.todo-comments")
spec("spuxy.lsp_signature")
spec("spuxy.rainbow")

spec("spuxy.illuminate")
spec("spuxy.schemastore")

-- Debuging
-- spec("spuxy.neotest")
spec("spuxy.debug.dap")
spec("spuxy.debug.ui")
spec("spuxy.debug.telescope")
spec("spuxy.debug.virtual-text")
spec("spuxy.debug.mason")
spec("spuxy.debug.go")
spec("spuxy.debug.python")

-- Languages
spec("spuxy.lsp.go.go-nvim")

-- TERM
spec("spuxy.toggleterm")
spec("spuxy.smart-splits")
require("spuxy.lazy")
