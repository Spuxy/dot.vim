local map = vim.keymap.set

-- Neogit
map("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Neogit" })

-- Navigation
map("n", "<leader>gj", "<cmd>lua require('gitsigns').next_hunk({navigation_message = false})<cr>", { desc = "Next Hunk" })
map("n", "<leader>gk", "<cmd>lua require('gitsigns').prev_hunk({navigation_message = false})<cr>", { desc = "Prev Hunk" })

-- Hunk operations
map("n", "<leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<cr>",      { desc = "Preview Hunk" })
map("n", "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<cr>",        { desc = "Reset Hunk" })
map("n", "<leader>gs", "<cmd>lua require('gitsigns').stage_hunk()<cr>",        { desc = "Stage Hunk" })
map("n", "<leader>gu", "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>",   { desc = "Undo Stage Hunk" })

-- Buffer operations
map("n", "<leader>gR", "<cmd>lua require('gitsigns').reset_buffer()<cr>", { desc = "Reset Buffer" })

-- Blame
map("n", "<leader>gl", "<cmd>lua require('gitsigns').blame_line()<cr>", { desc = "Blame Line" })
map("n", "<leader>gL", "<cmd>lua require('gitsigns').blame()<cr>",      { desc = "Blame Panel" })

-- Diff
map("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", { desc = "Git Diff" })

-- Browse
map({ "n", "v" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse" })

-- Telescope integrations
map("n", "<leader>go", "<cmd>Telescope git_status<cr>",   { desc = "Open Changed File" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Checkout Branch" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>",  { desc = "Checkout Commit" })
map("n", "<leader>gC", "<cmd>Telescope git_bcommits<cr>", { desc = "Checkout Commit (Current File)" })
