local M = {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
}

function M.config()
  require("nvim-surround").setup({})
end

-- keymaps
-- dsf - delete surround function -> fmt.P*intln(dec.Decode(js)) == dec.Decode(js)
-- ysiw) - surround word with ')' -> surr*ound_words == (surround_words)
-- ys$" - surround whole row - *make strings == "make strings"
-- Dot-repeatable

return M
