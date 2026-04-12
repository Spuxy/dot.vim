local M = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

function M.config()
  local harpoon = require("harpoon")
  harpoon:setup()

  local keymap = vim.keymap.set

  -- Mark / menu
  keymap("n", "<s-m>", function() harpoon:list():add() end, { desc = "Harpoon mark file" })
  keymap("n", "<leader>0", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })

  -- Jump to file by index
  keymap("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon 1" })
  keymap("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon 2" })
  keymap("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon 3" })
  keymap("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon 4" })

  -- Cycle through marks
  keymap("n", "[h", function() harpoon:list():prev() end, { desc = "Harpoon prev" })
  keymap("n", "]h", function() harpoon:list():next() end, { desc = "Harpoon next" })
end

return M
