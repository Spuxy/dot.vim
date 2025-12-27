
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
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true
      }
      local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
      for _, ls in ipairs(language_servers) do
          require('lspconfig')[ls].setup({
              capabilities = capabilities
              -- you can add other fields for setting up lsp server in this table
          })
      end
      require('ufo').setup(opts)
    end,
}

return M
