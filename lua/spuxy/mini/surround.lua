-- mini.surround — add/delete/replace surrounding pairs
--   Keymaps match nvim-surround (muscle memory preserved):
--
--   ysiw)   surround word with )   →  surr*ound_words == (surround_words)
--   ds)     delete surround )      →  (surround_words) == surround_words
--   cs)"    replace ) with "       →  (surround_words) == "surround_words"
--   dsf     delete surrounding function call
local M = {
  "nvim-mini/mini.surround",
  keys = {
    { "ys", desc = "Add surround" },
    { "ds", desc = "Delete surround" },
    { "cs", desc = "Replace surround" },
  },
  opts = {
    mappings = {
      add            = "ys",
      delete         = "ds",
      replace        = "cs",
      find           = "gsf",
      find_left      = "gsF",
      highlight      = "gsh",
      update_n_lines = "gsn",
    },
  },
}

return M
