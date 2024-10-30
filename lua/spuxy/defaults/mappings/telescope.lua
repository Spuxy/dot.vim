return {
    mappings = {
        { "<leader>bb", function() require("telescope.builtin").buffers({previewer=false}) end, desc = "Find" },
        { "<leader>fc", function() require("telescope.builtin").colorscheme() end, desc= "Colorscheme" },
        { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
        { "<leader>ft", function() require("telescope.builtint").live_grep() end, desc = "Find (Grep)" },
        { "<leader>fT", function() require("telescope.builtint").grep_string() end, desc = "Find (Text)" },
        { "<leader>fh", function() require("telescope.builtint").help_tags() end, desc = "Help" },
        { "<leader>fl", function() require("telescope.builtint").resume() end, desc = "Last Search" },
        { "<leader>fr", function() require("telescope.builtint").oldfiles() end, desc = "Recent File" },

        -- ["<leader>sc"] = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" }, -- because of treesitter selection
        ["<leader>sf"] = { "<cmd>Telescope find_files<cr>", "Find File" },
        ["<leader>sh"] = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        ["<leader>sH"] = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
        { "<leader>sM", function() require("telescope.builtint").man_pages() end, "Man Pages" },
        { "<leader>fr", function() require("telescope.builtint").oldfiles() end, desc = "Recent File" },
        { "<leader>sr", function() require("telescope.builtint").oldfiles() end, desc = "Recent File" },
        { "<leader>sR", function() require("telescope.builtint").registers() end, desc = "Registers" },
        { "<leader>st", function() require("telescope.builtint").live_grep() end, desc = "Find (Grep)" },
        { "<leader>sk", function() require("telescope.builtint").keymaps() end, desc = "Keymaps" },
        { "<leader>sC", function() require("telescope.builtint").commands() end, desc = "Commands" },
        { "<leader>sl", function() require("telescope.builtint").resume() end, desc = "Resume last search" },
    }
}