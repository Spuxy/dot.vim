-- if i need to add an option:
-- first -> check an option in :help options
-- second -> add that with prefix vim.opt.{option}
local options = {
  backup = false, -- creates a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  -- vim.opt.fileencoding = "utf-8" -- the encoding written to a file
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  mouse = "nv", -- mouse in normal/visual but not insert mode
  pumheight = 10, -- pop up menu height
  pumblend = 10,
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 1, -- always show tabs
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
  ttimeoutlen = 0, -- instant escape from insert mode / key code sequences
  undofile = true, -- enable persistent undo
  undolevels = 1000, -- maximum number of undo changes
  updatetime = 100, -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  breakindent = true, -- wrapped lines keep visual indentation
  linebreak = true, -- wrap at word boundaries (respects breakat)
  confirm = true, -- raise a dialog instead of failing for unsaved changes
  infercase = true, -- smarter keyword completion case inference
  shiftround = true, -- round indent to multiple of shiftwidth with </>/<<
  virtualedit = "block", -- allow cursor past EOL in visual block mode
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  laststatus = 3,
  showcmd = false,
  ruler = false,
  relativenumber = true, -- set relative numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  scrolloff = 10, -- keep 10 lines of context above/below cursor
  sidescrolloff = 8,
  guifont = "monospace:h17", -- the font used in graphical neovim applications
  title = false,
  foldcolumn = '0', -- snacks.statuscolumn draws the fold indicator itself
  foldmethod = "expr",
  foldexpr = "v:lua.vim.treesitter.foldexpr()",
  foldtext = "",  -- native foldtext: shows first line content (Neovim 0.12+)
  foldlevel = 99, -- start with all folds open
  foldlevelstart = 99,
  foldenable = true,
  -- colorcolumn = "80",
  -- colorcolumn = "120",
  --
  fillchars = vim.opt.fillchars + "eob: ,fold: ,foldopen:▾,foldsep: ,foldclose:▸",
  sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.fillchars:append({
  stl = " ",
})
vim.opt.shortmess:append("c")
vim.opt.diffopt:append("linematch:60") -- better diff alignment for lines up to 60 chars apart
vim.opt.diffopt:append("algorithm:histogram") -- histogram diff gives more readable hunks

-- Global floating window border (Neovim 0.11+)
if vim.fn.has("nvim-0.11") == 1 then
  vim.opt.winborder = "rounded"
end

-- Show invisible chars when :set list is toggled
vim.opt.listchars = { tab = "» ", trail = "·", extends = "›", precedes = "‹", nbsp = "␣" }

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]]) -- treats the word with dash as a word -> test-test is one word

vim.g.netrw_banner = 0
vim.g.netrw_mouse = 2
vim.g.disable_autoformat = false
