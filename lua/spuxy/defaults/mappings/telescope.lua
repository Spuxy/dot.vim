local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

M = {
    whichkey = {
        ["<leader>sb"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },

        ["<leader>sf"] = { "<cmd>Telescope find_files<cr>", "Find File" },
        ["<leader>sH"] = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
        ["<leader>st"] = { "<cmd>Telescope live_grep<cr>", "Text" },
        ["<leader>sT"] = { "<cmd>Telescope grep_string<cr>", "Find (grep)" },

        ["<leader>sh"] = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        ["<leader>sM"] = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        ["<leader>sR"] = { "<cmd>Telescope registers<cr>", "Registers" },
        ["<leader>sk"] = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        ["<leader>sC"] = { "<cmd>Telescope commands<cr>", "Commands" },

        ["<leader>sr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        ["<leader>sl"] = { "<cmd>Telescope resume<cr>", "Resume last search" },

        ["<leader>sZ"] = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" }, -- because of treesitter selection
    },

    default = {
        i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,

            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,

            ["<CR>"] = actions.select_default,

            ["<C-v>"] = actions.select_vertical,
            ["<C-h>"] = actions.select_horizontal,
            ["<C-t>"] = actions.select_tab,
            ["<C-?>"] = actions.which_key,

            -- ["<C-P>"] = action_layout.toggle_preview,
            -- ["<C-M>"] = action_layout.toggle_mirror,
        },
        n = {
            ["<esc>"] = actions.close,
            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["q"] = actions.close,
        },
    },

    buffer = {
        i = {
            ["<C-d>"] = actions.delete_buffer,
        },
        n = {
            ["dd"] = actions.delete_buffer,
        },
    }
}
return M