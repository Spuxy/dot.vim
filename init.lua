require("spuxy.core.keymaps")
require("spuxy.core.launch")
require("spuxy.core.options")
require("spuxy.core.autocmds")

spec("spuxy.whichkey")

-- AI
spec("spuxy.ai.copilot")
spec("spuxy.ai.copilotchat")

-- UI
spec("spuxy.mini.icon") -- mocks nvim-web-devicons API via package.preload
spec("spuxy.noice")

-- Collections of Libs
spec("spuxy.snacks")

-- MISC
spec("spuxy.trouble")
spec("spuxy.mini.splitjoin")
spec("spuxy.auto-session")
spec("spuxy.transparent")

-- Markdown
spec("spuxy.markdown")
spec("spuxy.markdown-preview")

-- COLORSCHEMES
spec("spuxy.colorschemes.tokyonight")

-- MOVEMENTS
spec("spuxy.mini.pairs")
spec("spuxy.telescope")
spec("spuxy.mini.surround")   -- ys/ds/cs keymaps
spec("spuxy.window-picker")
spec("spuxy.flash")
spec("spuxy.grug-far")
spec("spuxy.mini.align")
spec("spuxy.mini.indentscope")
spec("spuxy.mini.move")
spec("spuxy.mini.bracketed")
spec("spuxy.mini.trailspace")
spec("spuxy.mini.hipatterns")
spec("spuxy.ufo")
spec("spuxy.smart-splits")

-- FILESYSTEM
spec("spuxy.neotree")
spec("spuxy.oil")
spec("spuxy.lualine")

-- Projects manipulation
spec("spuxy.harpoon")

-- COMPLETIONS
spec("spuxy.completions.blink")
spec("spuxy.completions.lazydev")

-- TREESITTER
spec("spuxy.treesitter")
spec("spuxy.treesitter-textobjects")
spec("spuxy.treesitter-context")
spec("spuxy.rainbow")

-- LSP
spec("spuxy.bufferline")
spec("spuxy.lsp.lspconfig")
spec("spuxy.lsp.mason")
spec("spuxy.lsp.mason-lspconfig")
spec("spuxy.symbol-usage")
spec("spuxy.luasnip")
spec("spuxy.conform")

-- GIT
spec("spuxy.git.gitsigns")
spec("spuxy.git.neogit")
spec("spuxy.git.fugitive")

-- UI
spec("spuxy.bqf")
spec("spuxy.menu")
spec("spuxy.lspsaga")
spec("spuxy.todo-comments")
spec("spuxy.schemastore")

-- Debugging
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

-- Kubernetes / Infrastructure
spec("spuxy.kustomize")

-- LINTERS
spec("spuxy.linters.nvim-lint")

-- Notes
spec("spuxy.obsidian")

require("spuxy.lazy")

require("spuxy.core.functions")

local commands = require("spuxy.core.commands")
commands.load(commands.defaults)

require("spuxy.core.health")
