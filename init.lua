require("spuxy.core.keymaps")
require("spuxy.core.launch")
require("spuxy.core.options")

-- MISC
spec("spuxy.alpha")
spec("spuxy.devicons")
spec("spuxy.breadcrumbs")

-- COLORSCHEMES
-- spec("spuxy.colorschemes.gruvbox")
spec("spuxy.colorschemes.serenade")

-- MOVEMENTS
spec("spuxy.autopairs")
spec("spuxy.comment")
spec("spuxy.indentline")
spec("spuxy.bufferline")
spec("spuxy.telescope")
spec("spuxy.whichkey")
spec("spuxy.surround")

-- FILESYSTEM
spec("spuxy.neotree")
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
spec("spuxy.yamlcompanion")

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
spec("spuxy.neotest")

spec("spuxy.nvim-dap")
spec("spuxy.nvim-dap-go")
spec("spuxy.dapui")

require("spuxy.lazy")
