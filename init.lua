require("spuxy.core.keymaps")
require("spuxy.core.launch")
require("spuxy.core.options")

-- MISC
spec("spuxy.alpha")
spec("spuxy.devicons")
spec("spuxy.breadcrumbs")

-- COLORSCHEMES
--spec("spuxy.colorschemes.gruvbox-nvim")
-- spec("spuxy.colorschemes.pywal-nvim")
spec("spuxy.colorschemes.flow")

-- MOVEMENTS
spec("spuxy.autopairs") -- own keymaps
spec("spuxy.comment") -- own keymaps
spec("spuxy.indentline")
spec("spuxy.bufferline") -- own keymaps
spec("spuxy.telescope")
spec("spuxy.whichkey")
spec("spuxy.surround") -- own keymaps
spec("spuxy.window-picker") -- own keymaps

-- FILESYSTEM
spec("spuxy.neotree") -- own keymaps
spec("spuxy.lualine")

-- TERM
spec("spuxy.toggleterm")

-- Projects manipulation
spec("spuxy.project")
spec("spuxy.harpoon")

-- LSP
spec("spuxy.navic")
spec("spuxy.cmp")
spec("spuxy.neodev")
spec("spuxy.lspconfig")
spec("spuxy.none-ls")
spec("spuxy.mason")
spec("spuxy.treesitter")
spec("spuxy.treesitter-textobjects")
spec("spuxy.yamlcompanion")
-- spec("spuxy.navigator")
spec("spuxy.go-nvim")

-- GIT
spec("spuxy.gitsigns")
spec("spuxy.neogit")

-- UI
spec("spuxy.bqf")
spec("spuxy.lspsaga")
spec("spuxy.todo-comments")
spec("spuxy.lsp_signature")
spec("spuxy.rainbow")
-- spec("spuxy.guihua")

spec("spuxy.illuminate")
spec("spuxy.schemastore")
-- Debuging
spec("spuxy.neotest")

spec("spuxy.nvim-dap")
spec("spuxy.nvim-dap-go")
spec("spuxy.dapui")

spec("spuxy.smart-splits")

require("spuxy.lazy")
