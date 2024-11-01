require("which-key").register({
    ["<leader>bb"] = { "<cmd>BufferLinePick<cr>", "Jump" },
    ["<leader>bf"] = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
    ["<leader>bj"] = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
    ["<leader>bk"] = { "<cmd>BufferLineCycleNext<cr>", "Next" },
    ["<leader>bp"] = { "<cmd>BufferLineTogglePin<cr>", "Pin" },
    ["<leader>be"] = { "<cmd>BufferLinePickClose<cr>", "Pick which buffer to close" },
    ["<leader>bW"] = { "<cmd>noautocmd w<cr>", "Save without formatting (noautocmd)" },
    ["<leader>bD"] = { "<cmd>BufferLineSortByDirectory<cr>", "Sort by directory" },
    ["<leader>bL"] = { "<cmd>BufferLineSortByExtension<cr>", "Sort by language" },
})