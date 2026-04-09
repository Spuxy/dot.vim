-- flash.nvim: enhanced motion/search with labels
-- Native vim motions (s, S, r, R, f, t, F, T) are all preserved.
-- Flash enhances / and ? search with jump labels automatically.
-- <leader>j  → flash jump anywhere on screen
-- <leader>J  → flash treesitter node selection

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      char = { enabled = false },  -- don't touch f/t/F/T
    },
  },
  keys = {
    { "<leader>j",  mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash jump" },
    { "<leader>J",  mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
  },
}
