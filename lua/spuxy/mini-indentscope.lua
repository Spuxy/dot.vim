-- mini.indentscope: animates and highlights the indent scope your cursor is in
-- Complements snacks.indent (which draws static guide lines for all levels)
-- mini.indentscope highlights only the *current* scope with a distinct animated line

return {
  "nvim-mini/mini.indentscope",
  event = { "BufReadPre", "BufNewFile" },
  init = function()
    -- Disable in special buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
  opts = function()
    return {
      symbol = "│",
      options = { try_as_border = true },
      draw = {
        delay = 50,
        animation = require("mini.indentscope").gen_animation.none(),
      },
    }
  end,
}
