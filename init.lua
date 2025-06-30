require("spuxy.core.keymaps")
require("spuxy.core.launch")
require("spuxy.core.options")
require("spuxy.core.functions")

-- AI
spec("spuxy.ai.copilot")
spec("spuxy.ai.tabnine")

-- MISC
spec("spuxy.alpha")
spec("spuxy.devicons")
spec("spuxy.mini-icon")
spec("spuxy.barbecue")
spec("spuxy.noice")
spec("spuxy.notify")
spec("spuxy.trouble")
spec("spuxy.treesj")
spec("spuxy.markdown")
spec("spuxy.markdown-preview")
-- spec("spuxy.auto-session")
spec("spuxy.transparent")

-- COLORSCHEMES
-- spec("spuxy.colorschemes.gruvbox-nvim")
-- spec("spuxy.colorschemes.gruvbox")
--spec("spuxy.colorschemes.pywal-nvim")
-- spec("spuxy.colorschemes.flow")
spec("spuxy.colorschemes.miasma")
-- spec("spuxy.colorschemes.neopywal-nvim")

-- MOVEMENTS
spec("spuxy.autopairs") -- own keymaps
spec("spuxy.comment") -- own keymaps
spec("spuxy.indentline")
spec("spuxy.bufferline") -- own keymaps
spec("spuxy.telescope")
spec("spuxy.whichkey")
spec("spuxy.surround") -- own keymaps
spec("spuxy.window-picker") -- pickign window - own keymaps
spec("spuxy.spectre")
spec("spuxy.smart-splits") -- spliting and moving cursor and buffers
spec("spuxy.ufo") -- spliting and moving cursor and buffers
spec("spuxy.substitute") -- spliting and moving cursor and buffers

-- FILESYSTEM
spec("spuxy.neotree") -- own keymaps
spec("spuxy.lualine")

-- Projects manipulation
spec("spuxy.project")
spec("spuxy.harpoon")

-- LSP
spec("spuxy.navic")
spec("spuxy.cmp") -- when i write, it pops menu to pick function + with tab it will complete func call with arguments and i change thm easily
-- spec("spuxy.neodev") -- delet because of lazdyev
spec("spuxy.lsp.lspconfig")
-- spec("spuxy.lsp.none-ls")
spec("spuxy.lsp.mason")
spec("spuxy.treesitter")
spec("spuxy.treesitter-textobjects")
spec("spuxy.yamlcompanion")
-- spec("spuxy.navigator")
spec("spuxy.symbol-usage")
spec("spuxy.luasnip")
spec("spuxy.conform")

-- GIT
spec("spuxy.gitsigns")
spec("spuxy.neogit")

-- UI
spec("spuxy.bqf")
spec("spuxy.lspsaga")
spec("spuxy.todo-comments")
spec("spuxy.lsp_signature")
spec("spuxy.rainbow")
spec("spuxy.dressing")
spec("spuxy.overseer")

spec("spuxy.illuminate")
spec("spuxy.schemastore")

-- Debuging
spec("spuxy.neotest")
spec("spuxy.debug.dap")
spec("spuxy.debug.ui")
spec("spuxy.debug.telescope")
spec("spuxy.debug.virtual-text")
spec("spuxy.debug.mason")
spec("spuxy.debug.go")
spec("spuxy.debug.python")

-- Languages
spec("spuxy.lsp.go.go-nvim")

spec("spuxy.lint")

-- TERM
spec("spuxy.toggleterm")
require("spuxy.lazy")
