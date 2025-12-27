local icons = require("spuxy.core.icons")
local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "AndreM222/copilot-lualine",
    "RedsXDD/neopywal.nvim",
    "uZer/pywal16.nvim",
    "rmagatti/auto-session",
  },
  -- https://github.com/folke/trouble.nvim?tab=readme-ov-file#statusline-component
  opts = {
    options = {
      ignore_focus = { "NvimTree" },
      icons_enabled = true,
      theme = "pywal-nvim",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      -- ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff" },
      lualine_c = { "diagnostics" },
      lualine_x = {
        function()
          return string.format("%s%s", icons.misc.Session, require("auto-session.lib").current_session_name(true))
        end,
        "copilot",
        "encoding",
        "fileformat",
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = { "quickfix", "man", "fugitive" },
  },
  config = function(_, opts)
    require("neopywal.theme.plugins.lualine").setup()
    -- opts.options.theme = "neopywal"
    opts.options.theme = "pywal16-nvim"
    require("lualine").setup(opts)
  end,
}

return M
