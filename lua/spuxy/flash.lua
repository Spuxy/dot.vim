-- flash.nvim: enhanced motion/search with labels
-- S  → jump anywhere on screen with 2 chars
-- ss → treesitter node selection
-- r  → remote flash (operator-pending: act on distant text)
-- f/t/F/T → enhanced with labels

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      -- enhance f/t/F/T with jump labels
      char = {
        jump_labels = true,
      },
      -- treesitter integration for S
      treesitter = {
        labels = "abcdefghijklmnopqrstuvwxyz",
      },
    },
  },
  keys = {
    { "s",  mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash jump" },
    { "S",  mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash treesitter" },
    { "r",  mode = "o",               function() require("flash").remote() end,            desc = "Remote flash" },
    { "R",  mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter search" },
    { "<c-s>", mode = { "c" },        function() require("flash").toggle() end,            desc = "Toggle flash search" },
  },
}
