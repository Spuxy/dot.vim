local utils = require("spuxy.core.functions")
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Leader key 'Space'
keymap("n", "<Space>", "", opts)

keymap("n", "<C-i>", "<C-i>", opts)

-- Remap for dealing with visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- paste over currently selected text without yanking it
keymap("v", "p", '"_dp')
keymap("v", "P", '"_dP')

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-tab>", "<c-6>", opts)

-- Close current window
keymap("n", "<leader>wc", "<cmd>close<cr>", { desc = "Close" })

-- Window rotate
keymap("n", "<leader>wr", "<cmd>wincmd r<cr>", { desc = "rotate down/right" })
keymap("n", "<leader>wR", "<cmd>wincmd R<cr>", { desc = "rotate up/left" })

-- Window moving
keymap("n", "<leader>wH", "<cmd>wincmd H<cr>", { desc = "Move left" })
keymap("n", "<leader>wJ", "<cmd>wincmd J<cr>", { desc = "Move down" })
keymap("n", "<leader>wK", "<cmd>wincmd K<cr>", { desc = "Move up" })
keymap("n", "<leader>wL", "<cmd>wincmd L<cr>", { desc = "Move right" })

-- Window resizing
keymap("n", "<leader>wm", "<cmd>WindowsMaximize<cr>", { desc = "Maximize" })
keymap("n", "<leader>w=", "<cmd>wincmd =<cr>", { desc = "Equalize size" })
keymap("n", "<leader>wk", "<cmd>resize +5<cr>", { desc = "Up" })
keymap("n", "<leader>wj", "<cmd>resize -5<cr>", { desc = "Down" })
keymap("n", "<leader>wh", "<cmd>vertical resize +3<cr>", { desc = "Left" })
keymap("n", "<leader>wl", "<cmd>vertical resize -3<cr>", { desc = "Right" })

keymap("n", "<C-Up>", "<cmd>resize +5<cr>", { desc = "Up" })
keymap("n", "<C-Down>", "<cmd>resize -5<cr>", { desc = "Down" })
keymap("n", "<C-Left>", "<cmd>vertical resize +3<cr>", { desc = "Left" })
keymap("n", "<C-Right>", "<cmd>vertical resize -3<cr>", { desc = "Right" })

-- buffers
keymap("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
--map("n", "<leader>bD", "<cmd>%bd|e#|bd#<cr>", { desc = "Close all but the current buffer" })
--map("n", "<leader>bd", "<cmd>Bdelete<cr>", { desc = "Close buffer" })
--map("n", "<leader><tab>", "<cmd>e#<cr>", { desc = "Previous Buffer" }) -- TODO: better desc

keymap("n", "<C-p>", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<C-n>", "<cmd>Neotree toggle<cr>", opts)

-- Clear highlight on pressing <Esc> in normal mode
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- move over a closing element in insert mode
keymap("i", "<C-l>", function()
  return require("spuxy.core.functions").escapePair()
end)

-- save like your are used to
keymap({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- new file
keymap("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })

-- search and replace is a pain with a German keyboard layout
keymap({ "v", "n" }, "<leader>r", ":%s/", { desc = "Buffer search and replace" })

-- toggles
keymap("n", "<leader>Tn", function()
  vim.o.number = vim.o.number == false and true or false
  vim.o.relativenumber = vim.o.relativenumber == false and true or false
end, { desc = "Toggle relative number" })
keymap("n", "<leader>Th", function()
  utils.notify("Toggling hidden chars", vim.log.levels.INFO, "core.mappings")
  vim.o.list = vim.o.list == false and true or false
end, { desc = "Toggle hidden chars" })
keymap("n", "<leader>Tl", function()
  utils.notify("Toggling signcolumn", vim.log.levels.INFO, "core.mappings")
  vim.o.signcolumn = vim.o.signcolumn == "yes" and "no" or "yes"
end, { desc = "Toggle signcolumn" })
keymap("n", "<leader>Tv", function()
  utils.notify("Toggling virtualedit", vim.log.levels.INFO, "core.mappings")
  vim.o.virtualedit = vim.o.virtualedit == "all" and "block" or "all"
end, { desc = "Toggle virtualedit" })
keymap("n", "<leader>Ts", function()
  utils.notify("Toggling spell", vim.log.levels.INFO, "core.mappings")
  vim.o.spell = vim.o.spell == false and true or false
end, { desc = "Toggle spell" })
keymap("n", "<leader>Tw", function()
  utils.notify("Toggling wrap", vim.log.levels.INFO, "core.mappings")
  vim.o.wrap = vim.o.wrap == false and true or false
end, { desc = "Toggle wrap" })
keymap("n", "<leader>Tc", function()
  utils.notify("Toggling cursorline", vim.log.levels.INFO, "core.mappings")
  vim.o.cursorline = vim.o.cursorline == false and true or false
end, { desc = "Toggle cursorline" })
keymap("n", "<leader>TO", "<cmd>lua require('spuxy.core.functions').toggle_colorcolumn()<cr>", { desc = "Toggle colorcolumn" })
keymap(
  "n",
  "<leader>Tt",
  "<cmd>lua require('spuxy.lsp.utils').toggle_virtual_text()<cr>",
  { desc = "Toggle Virtualtext" }
)
keymap("n", "<leader>TS", "<cmd>windo set scb!<cr>", { desc = "Toggle Scrollbind" })

-- Spelling
keymap("n", "<leader>zl", "<cmd>Telescope spell_suggest<cr>", { desc = "List corrections" })
keymap("n", "<leader>zf", "1z=", { desc = "Use first correction" })
keymap("n", "<leader>zj", "]s", { desc = "Next error" })
keymap("n", "<leader>zk", "[s", { desc = "Previous error" })
keymap("n", "<leader>za", "zg", { desc = "Add word" })

-- Reload snippets folder
-- TODO make path system independent
keymap("n", "<leader>ms", "<cmd>source ~/.config/nvim/snippets/*<cr>", { desc = "Reload snippets" })

-- Quickfix
keymap("n", "<leader>qj", "<cmd>cnext<cr>", { desc = "Next entry" })
keymap("n", "<leader>qk", "<cmd>cprevious<cr>", { desc = "Previous entry" })
keymap("n", "<leader>qq", "<cmd>lua require('spuxy.core.functions').toggle_qf()<cr>", { desc = "Toggle Quickfix" })
-- Search for 'FIXME', 'HACK', 'TODO', 'NOTE'
keymap("n", "<leader>qt", function()
  utils.search_todos()
end, { desc = "List TODOs" })

-- centered search results
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("x", "p", [["_dP]])

vim.cmd([[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]])
vim.cmd([[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]])
-- vim.cmd [[:amenu 10.120 mousemenu.-sep- *]]

-- keymap("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
keymap("n", "<RightMouse>", function()
  require("menu.utils").delete_old_menus()

  vim.cmd.exec("\"normal! \\<RightMouse>\"")

  -- clicked buf
  local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
  local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

  require("menu").open(options, { mouse = true })
end, {})

-- more good
keymap({ "n", "o", "x" }, "<s-h>", "^", opts)
keymap({ "n", "o", "x" }, "<s-l>", "g_", opts)

-- tailwind bearable to work with
keymap({ "n", "x" }, "j", "gj", opts)
keymap({ "n", "x" }, "k", "gk", opts)
keymap("n", "<leader>w", ":lua vim.wo.wrap = not vim.wo.wrap<CR>", opts)

vim.api.nvim_set_keymap("t", "<C-;>", "<C-\\><C-n>", opts)



-- Simple tree
keymap("n", "<leader>pv", vim.cmd.Ex, opts)
