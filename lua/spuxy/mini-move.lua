-- mini.move: move any selection in any direction
-- <M-h/j/k/l> → move line or visual selection left/down/up/right (Alt)

return {
  "nvim-mini/mini.move",
  keys = {
    { "<M-h>", mode = { "n", "v" } },
    { "<M-j>", mode = { "n", "v" } },
    { "<M-k>", mode = { "n", "v" } },
    { "<M-l>", mode = { "n", "v" } },
  },
  opts = {
    mappings = {
      left  = "<M-h>",
      down  = "<M-j>",
      up    = "<M-k>",
      right = "<M-l>",
    },
  },
}
