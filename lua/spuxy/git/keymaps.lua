local wk = require("which-key")

-- Git operations via Gitsigns
wk.add({
  -- Neogit
  { "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit"},

  -- Navigation
  { "<leader>gj", "<cmd>lua require('gitsigns').next_hunk({navigation_message = false})<cr>", desc = "Next Hunk" },
  { "<leader>gk", "<cmd>lua require('gitsigns').prev_hunk({navigation_message = false})<cr>", desc = "Prev Hunk" },

  -- Hunk operations
  { "<leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<cr>", desc = "Preview Hunk" },
  { "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<cr>", desc = "Reset Hunk" },
  { "<leader>gs", "<cmd>lua require('gitsigns').stage_hunk()<cr>", desc = "Stage Hunk" },
  { "<leader>gu", "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", desc = "Undo Stage Hunk" },

  -- Buffer operations
  { "<leader>gR", "<cmd>lua require('gitsigns').reset_buffer()<cr>", desc = "Reset Buffer" },

  -- Blame
  { "<leader>gl", "<cmd>lua require('gitsigns').blame_line()<cr>", desc = "Blame Line" },
  { "<leader>gL", "<cmd>lua require('gitsigns').blame()<cr>", desc = "Blame Panel" },

  -- Diff
  { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Git Diff" },

  -- Telescope integrations
  { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open Changed File" },
  { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout Branch" },
  { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout Commit" },
  { "<leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "Checkout Commit (Current File)" },

  -- Toggles
  { "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle Inline Blame" },
})
