-- mini.bracketed: go forward/backward with square brackets
-- Adds [/] jumps for: buffers, comments, conflicts, diagnostics,
-- files, indent, jumps, locations, oldfiles, quickfix, treesitter, undo, windows, yank

return {
  "nvim-mini/mini.bracketed",
  event = "VeryLazy",
  opts = {
    -- disable treesitter jumps — handled by nvim-treesitter-textobjects
    treesitter = { suffix = "" },
    -- disable diagnostic jumps — already have [e/]e and [w/]w in keymaps
    diagnostic  = { suffix = "" },
  },
}
