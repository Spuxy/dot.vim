-- oil.nvim — edit your filesystem like a buffer
--
-- Open parent directory with `-`, edit filenames inline, save with :w to apply.
-- Coexists with neo-tree: neo-tree is a sidebar tree, oil is a buffer-based editor.

local M = {
  "stevearc/oil.nvim",
  lazy = false, -- oil replaces netrw, must load early
  dependencies = { "nvim-mini/mini.icons" },
  opts = {
    default_file_explorer = true,
    columns = {
      "icon",
    },
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-s>"] = "actions.select_split",
      ["<C-t>"] = false, -- don't override our terminal keymap
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-r>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
    },
    float = {
      padding = 2,
      max_width = 120,
      max_height = 30,
      border = "rounded",
    },
  },
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory (Oil)" },
    { "<leader>fo", "<cmd>Oil --float<cr>", desc = "Oil (float)" },
  },
}

return M
