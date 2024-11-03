
local M = {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        { "kevinhwang91/promise-async" },
    },
    keys = {
        { "<leader>mu", "", desc = "UFO" },
        { "<leader>muu", "<cmd>UfoToggle<cr>", desc = "Toggle" },
        { "<leader>muo", "<cmd>UfoOpen<cr>", desc = "Open" },
        { "<leader>mus", "<cmd>UfoSend<cr>", desc = "Send" },
    },
    opts = {
        {
            open_fold_hl_timeout = 150,
            preview = {
                win_config = {
                    border = {'', '─', '', '', '', '─', '', ''},
                    winhighlight = 'Normal:Folded',
                    winblend = 0
                },
                mappings = {
                    scrollU = '<C-u>',
                    scrollD = '<C-d>',
                    jumpTop = '[',
                    jumpBot = ']'
                }
            },
        }
    },
    config = function(_, opts)
        require("ufo").setup(opts)
    end,
}

return M
