local M = {
  'kevinhwang91/nvim-bqf',
  ft = "qf",
  opts = {
    auto_enable = true,
    auto_resize_height = true,
    func_map = {
      split = '<C-h>',
    },
    preview = {
      win_height = 12,
      win_vheight = 12,
      delay_syntax = 80,
      border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
      should_preview_cb = function(bufnr, _)
        local ret = true
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        local fsize = vim.fn.getfsize(bufname)
        if fsize > 100 * 1024 then
          -- skip file size greater than 100k
          ret = false
        elseif bufname:match("^fugitive://") then
          -- skip fugitive buffer
          ret = false
        end
        return ret
      end,
    },
  },
  dependencies = {
    'junegunn/fzf',
  }
}

return M
