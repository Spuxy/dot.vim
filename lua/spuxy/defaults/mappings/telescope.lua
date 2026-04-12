local actions = require("telescope.actions")

local map = vim.keymap.set

M = {
    whichkey = function()
      map("n", "<leader>sb", "<cmd>Telescope git_branches<cr>",  { desc = "Checkout branch" })
      map("n", "<leader>sf", "<cmd>Telescope find_files<cr>",    { desc = "Find File" })
      map("n", "<leader>sH", "<cmd>Telescope highlights<cr>",    { desc = "Find highlight groups" })
      map("n", "<leader>st", "<cmd>Telescope live_grep<cr>",     { desc = "Text" })
      map("n", "<leader>sh", "<cmd>Telescope help_tags<cr>",     { desc = "Find Help" })
      map("n", "<leader>sM", "<cmd>Telescope man_pages<cr>",     { desc = "Man Pages" })
      map("n", "<leader>sR", "<cmd>Telescope registers<cr>",     { desc = "Registers" })
      map("n", "<leader>sk", "<cmd>Telescope keymaps<cr>",       { desc = "Keymaps" })
      map("n", "<leader>sC", "<cmd>Telescope commands<cr>",      { desc = "Commands" })
      map("n", "<leader>sr", "<cmd>Telescope oldfiles<cr>",      { desc = "Open Recent File" })
      map("n", "<leader>sl", "<cmd>Telescope resume<cr>",        { desc = "Resume last search" })
      map("n", "<leader>sZ", "<cmd>Telescope colorscheme<cr>",   { desc = "Colorscheme" })
      map("n", "<leader>sY", "<cmd>Telescope yaml_schema<cr>",   { desc = "Yaml Schema store" })
    end,

    default = {
        i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,

            ["<Tab>"]   = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,

            ["<CR>"]  = actions.select_default,
            ["<C-v>"] = actions.select_vertical,
            ["<C-h>"] = actions.select_horizontal,
            ["<C-t>"] = actions.select_tab,
            ["<C-?>"] = actions.which_key,
            ["<C-c>"] = actions.close,

            ["<C-q>"] = function(...)
              actions.smart_send_to_qflist(...)
              actions.open_qflist(...)
            end,
        },
        n = {
            ["<esc>"] = actions.close,
            ["<C-c>"] = actions.close,
            ["j"]     = actions.move_selection_next,
            ["k"]     = actions.move_selection_previous,
            ["q"]     = actions.close,

            ["<C-q>"] = function(...)
              actions.smart_send_to_qflist(...)
              actions.open_qflist(...)
            end,
        },
    },

    buffer = {
        i = { ["<C-d>"] = actions.delete_buffer },
        n = { ["dd"]    = actions.delete_buffer },
    },
}
return M
