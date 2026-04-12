-- treesitter-textobjects: select, move, and swap code with treesitter awareness
--
-- Select: use with any operator (d, c, y, v, =, gq, etc.)
-- Move:   jump between functions, classes, parameters with [/]
-- Swap:   reorder function arguments with <leader>xp / <leader>xP
-- Repeat: ; repeats last move forward, , repeats backward (also works for f/t)

local M = {
  "nvim-treesitter/nvim-treesitter-textobjects",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local select = require("nvim-treesitter-textobjects.select")
    local move = require("nvim-treesitter-textobjects.move")
    local swap = require("nvim-treesitter-textobjects.swap")
    local ts_repeat = require("nvim-treesitter-textobjects.repeatable_move")

    -- Config: lookahead for select, set_jumps for move
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
        selection_modes = {
          ["@parameter.outer"] = "v",
          ["@function.outer"] = "V",
          ["@class.outer"] = "<c-v>",
        },
        include_surrounding_whitespace = false,
      },
      move = {
        set_jumps = true,
      },
    })

    -- ── SELECT ──────────────────────────────────────────────────────
    local select_maps = {
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["at"] = "@class.outer",
      ["it"] = "@class.inner",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
      ["aa"] = "@parameter.outer",
      ["ia"] = "@parameter.inner",
      ["al"] = "@loop.outer",
      ["il"] = "@loop.inner",
      ["ai"] = "@conditional.outer",
      ["ii"] = "@conditional.inner",
      ["a/"] = "@comment.outer",
      ["i/"] = "@comment.inner",
      ["ab"] = "@block.outer",
      ["ib"] = "@block.inner",
      ["as"] = "@statement.outer",
      ["aA"] = "@attribute.outer",
      ["iA"] = "@attribute.inner",
    }
    for key, query in pairs(select_maps) do
      vim.keymap.set({ "x", "o" }, key, function()
        select.select_textobject(query)
      end, { desc = "TS: " .. query })
    end

    -- ── MOVE ────────────────────────────────────────────────────────
    local move_maps = {
      { "]f", move.goto_next_start,     "@function.outer", "Next function start" },
      { "]F", move.goto_next_end,       "@function.outer", "Next function end" },
      { "]a", move.goto_next_start,     "@parameter.inner", "Next argument" },
      { "]l", move.goto_next_start,     "@loop.outer",      "Next loop" },
      { "[f", move.goto_previous_start, "@function.outer", "Prev function start" },
      { "[F", move.goto_previous_end,   "@function.outer", "Prev function end" },
      { "[a", move.goto_previous_start, "@parameter.inner", "Prev argument" },
      { "[l", move.goto_previous_start, "@loop.outer",      "Prev loop" },
    }
    for _, m in ipairs(move_maps) do
      vim.keymap.set({ "n", "x", "o" }, m[1], function() m[2](m[3]) end, { desc = m[4] })
    end

    -- ── SWAP ────────────────────────────────────────────────────────
    vim.keymap.set("n", "<leader>xp", function()
      swap.swap_next("@parameter.inner")
    end, { desc = "Swap with next param" })
    vim.keymap.set("n", "<leader>xP", function()
      swap.swap_previous("@parameter.inner")
    end, { desc = "Swap with prev param" })

    -- ── REPEATABLE MOTIONS ──────────────────────────────────────────
    -- ; repeats last treesitter move forward, , repeats backward
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat.repeat_last_move_previous)
    -- Also make f/t/F/T repeatable through the same ; and , keys
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat.builtin_T_expr, { expr = true })
  end,
}

return M
