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
keymap("v", "p", "\"_dp")
keymap("v", "P", "\"_dP")

-- Window navigation — superseded by smart-splits.nvim (see lua/spuxy/smart-splits.lua)
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-tab>", "<c-6>", opts)

-- Windows (<leader>w)
keymap("n", "<leader>wc", "<cmd>close<cr>", { desc = "Close" })
keymap("n", "<leader>wm", "<cmd>WindowsMaximize<cr>", { desc = "Maximize" })
keymap("n", "<leader>w=", "<cmd>wincmd =<cr>", { desc = "Equalize" })
keymap("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Vertical split" })
keymap("n", "<leader>wh", "<cmd>split<cr>", { desc = "Horizontal split" })

-- Splits subgroup (<leader>ws) — rotate + resize
keymap("n", "<leader>wsr", "<cmd>wincmd r<cr>", { desc = "Rotate down/right" })
keymap("n", "<leader>wsR", "<cmd>wincmd R<cr>", { desc = "Rotate up/left" })
keymap("n", "<leader>wsk", "<cmd>resize +5<cr>", { desc = "Resize up" })
keymap("n", "<leader>wsj", "<cmd>resize -5<cr>", { desc = "Resize down" })
keymap("n", "<leader>wsl", "<cmd>vertical resize +5<cr>", { desc = "Resize right" })
keymap("n", "<leader>wsh", "<cmd>vertical resize -5<cr>", { desc = "Resize left" })
-- Swap buffers between splits (smart-splits — see lua/spuxy/smart-splits.lua)
-- <leader>wH / wJ / wK / wL

-- Window moving — superseded by smart-splits swap_buf (see lua/spuxy/smart-splits.lua)
-- keymap("n", "<leader>wH", "<cmd>wincmd H<cr>", { desc = "Move left" })
-- keymap("n", "<leader>wJ", "<cmd>wincmd J<cr>", { desc = "Move down" })
-- keymap("n", "<leader>wK", "<cmd>wincmd K<cr>", { desc = "Move up" })
-- keymap("n", "<leader>wL", "<cmd>wincmd L<cr>", { desc = "Move right" })

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

-- Files (<leader>f)
keymap("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })
keymap("n", "<leader>fr", function() Snacks.rename.rename_file() end, { desc = "Rename file" })
keymap("n", "<leader>fd", function() require("spuxy.core.functions").duplicate_file() end, { desc = "Duplicate file" })
keymap("n", "<leader>fp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, { desc = "Copy file path" })


-- toggles (Tn/Th/Tl/Tv/Ts/Tw/Tc/TO/Tt/Tb/TI/Td/Ti/TW → snacks.lua init)

-- Spelling
keymap("n", "<leader>zl", "<cmd>Telescope spell_suggest<cr>", { desc = "List corrections" })
keymap("n", "<leader>zf", "1z=", { desc = "Use first correction" })
keymap("n", "<leader>zj", "]s", { desc = "Next error" })
keymap("n", "<leader>zk", "[s", { desc = "Previous error" })
keymap("n", "<leader>za", "zg", { desc = "Add word" })

-- Reload snippets folder
keymap("n", "<leader>mr", "<cmd>source " .. vim.fn.stdpath("config") .. "/snippets/*<cr>", { desc = "Reload snippets" })

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
  local options = vim.bo[buf].ft == "neo-tree" and "nvimtree" or "default"

  require("menu").open(options, { mouse = true })
end, {})

-- more good
keymap({ "n", "o", "x" }, "<s-h>", "^", opts)
keymap({ "n", "o", "x" }, "<s-l>", "g_", opts)

vim.api.nvim_set_keymap("t", "<C-;>", "<C-\\><C-n>", opts)

-- Diagnostic navigation (error/warning severity)
keymap("n", "[e", function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Previous error" })
keymap("n", "]e", function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next error" })
keymap("n", "[w", function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN })
end, { desc = "Previous warning" })
keymap("n", "]w", function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN })
end, { desc = "Next warning" })

-- Add a commented line below/above (AstroNvim style, requires comment plugin)
keymap("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add comment below" })
keymap("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add comment above" })

