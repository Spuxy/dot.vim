
local M = {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        { "kevinhwang91/promise-async" },
    },
    opts = {
        open_fold_hl_timeout = 150,
        provider_selector = function(bufnr, filetype, buftype)
            if filetype == 'sagaoutline' or filetype == "neo-tree" then
                return ''
            end
            return {'treesitter', 'indent'}
        end,
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
    },
    config = function(_, opts)
      vim.o.fillchars = [[eob: ,fold: ,foldopen:▾,foldsep: ,foldclose:▸]]

      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      require('ufo').setup(opts)
    end,
}

return M
