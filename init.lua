require("spuxy.core.keymaps")
require("spuxy.core.launch")
require("spuxy.core.options")
require("spuxy.core.autocmds")

spec("spuxy.whichkey")

-- AI
spec("spuxy.ai.copilot")
-- tabnine removed: empty config(), copilot.vim is the active AI completion
spec("spuxy.ai.copilotchat")
-- spec("spuxy.ai.chatgpt") i dont use it atm, i need openai token which requires my creditcard ^^

-- UI
spec("spuxy.alpha")
-- devicons removed: mini-icon.lua already mocks nvim-web-devicons API via package.preload
spec("spuxy.mini-icon")
spec("spuxy.noice")
spec("spuxy.notify")

-- MISC
spec("spuxy.trouble")
spec("spuxy.treesj")
spec("spuxy.auto-session")
spec("spuxy.transparent")
-- overseer removed: all keymaps were commented out — no way to invoke the plugin

-- Markdown
-- render-markdown disabled: treesitter injection crash (set-lang-from-info-string! / nil node:range())
-- spec("spuxy.markdown")
spec("spuxy.markview")
spec("spuxy.markdown-preview")

-- COLORSCHEMES
spec("spuxy.colorschemes.tokyonight")

-- MOVEMENTS
spec("spuxy.autopairs") -- own keymaps
spec("spuxy.comment") -- own keymaps
spec("spuxy.indentline")
spec("spuxy.telescope")
spec("spuxy.surround") -- own keymaps
spec("spuxy.window-picker") -- pickign window - own keymaps
spec("spuxy.flash")
spec("spuxy.spectre")
spec("spuxy.grug-far")
spec("spuxy.mini-align")
spec("spuxy.ufo") -- spliting and moving cursor and buffers
-- substitute removed: opts = {}, no keymaps configured — does nothing

-- FILESYSTEM
spec("spuxy.neotree") -- own keymaps
spec("spuxy.lualine")

-- Projects manipulation
spec("spuxy.project")
spec("spuxy.harpoon")

-- COMPLETIONS
-- spec("spuxy.completions.blink") -- when i write, it pops menu to pick function + with tab it will complete func call with arguments and i change thm easily
-- spec("spuxy.completions.lazydev")
spec("spuxy.completions.cmp") -- when i write, it pops menu to pick function + with tab it will complete func call with arguments and i change thm easily

-- LSP
-- navic removed: lspsaga provides symbols_in_winbar with more features
spec("spuxy.bufferline") -- own keymaps
spec("spuxy.lsp.lspconfig")
spec("spuxy.lsp.mason")
spec("spuxy.lsp.mason-lspconfig")
spec("spuxy.treesitter")
spec("spuxy.treesitter-textobjects")
spec("spuxy.yamlcompanion")
-- spec("spuxy.navigator")
spec("spuxy.symbol-usage")
spec("spuxy.luasnip")
spec("spuxy.conform")

-- GIT
spec("spuxy.git.gitsigns")
spec("spuxy.git.neogit")
spec("spuxy.git.fugitive")

-- UI
spec("spuxy.bqf")
-- spec("spuxy.menu")
spec("spuxy.lspsaga")
spec("spuxy.todo-comments")
spec("spuxy.lsp_signature")
spec("spuxy.rainbow")

spec("spuxy.illuminate")
spec("spuxy.schemastore")

-- Debuging
spec("spuxy.neotest")
spec("spuxy.debug.dap")
spec("spuxy.debug.ui")
spec("spuxy.debug.telescope")
spec("spuxy.debug.virtual-text")
spec("spuxy.debug.mason")
spec("spuxy.debug.go.settings")
spec("spuxy.debug.python.settings")

-- Languages
spec("spuxy.lsp.go.go-nvim")
spec("spuxy.lsp.go.godoc")
spec("spuxy.lsp.go.gopher")

spec("spuxy.lsp.c.clangd-nvim")

-- LINTERS
spec("spuxy.linters.nvim-lint")

-- TERM
spec("spuxy.toggleterm")

-- Notes
spec("spuxy.obsidian")

require("spuxy.lazy")

require("spuxy.core.functions")

local commands = require("spuxy.core.commands")
commands.load(commands.defaults)

require("spuxy.core.health")

-- ARCHIVE
-- spec("spuxy.dressing")
-- spec("spuxy.barbecue")
-- spec("spuxy.colorschemes.gruvbox-nvim")
-- spec("spuxy.colorschemes.gruvbox")
-- spec("spuxy.colorschemes.pywal-nvim")
-- spec("spuxy.colorschemes.pywal16-nvim")
-- spec("spuxy.colorschemes.flow")
-- spec("spuxy.colorschemes.miasma")
-- spec("spuxy.colorschemes.neopywal-nvim")
-- spec("spuxy.markview") It can be used as alternative to 'markdown'

-- spec("spuxy.lsp.none-ls")
-- spec("spuxy.neodev") -- delet because of lazdyev
-- spec("spuxy.barbecue")

-- spec("spuxy.smart-splits") -- spliting and moving cursor and buffers
