local M = {
  'kevinhwang91/nvim-bqf',
  dependencies = {
    'junegunn/fzf',
  }
}

function M.config()
  require('bqf').setup({
    func_map = {},
  })
end

return M
