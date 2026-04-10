-- Eviline config for lualine
-- Credit: shadmansaleh & glepnir
local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-mini/mini.icons",
    "AndreM222/copilot-lualine",
    "rmagatti/auto-session",
  },
  config = function()
    local lualine = require("lualine")
    local icons = require("spuxy.core.icons")
    local miniicons = require("mini.icons")

    local colors = {
      bg = "#202328",
      fg = "#bbc2cf",
      yellow = "#ECBE7B",
      cyan = "#008080",
      darkblue = "#081633",
      green = "#98be65",
      orange = "#FF8800",
      violet = "#a9a1e1",
      magenta = "#c678dd",
      blue = "#51afef",
      red = "#ec5f67",
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    local config = {
      options = {
        component_separators = "",
        section_separators = "",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "neo-tree" } },
        theme = {
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    -- ┤ Left side ├ --

    ins_left({
      function()
        local mode_names = {
          n = "NORMAL",
          i = "INSERT",
          v = "VISUAL",
          V = "V-LINE",
          ["\22"] = "V-BLOCK",
          c = "COMMAND",
          no = "NORMAL",
          s = "SELECT",
          S = "S-LINE",
          ["\19"] = "S-BLOCK",
          ic = "INSERT",
          R = "REPLACE",
          Rv = "V-REPLACE",
          cv = "COMMAND",
          ce = "COMMAND",
          r = "PROMPT",
          rm = "MORE",
          ["r?"] = "CONFIRM",
          ["!"] = "SHELL",
          t = "TERMINAL",
        }
        return "" .. " " .. (mode_names[vim.fn.mode()] or "NORMAL")
      end,
      color = function()
        local mode_color = {
          n = colors.red,
          i = colors.green,
          v = colors.blue,
          V = colors.blue,
          ["\22"] = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          ["\19"] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ["r?"] = colors.cyan,
          ["!"] = colors.red,
          t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] or colors.fg, gui = "bold" }
      end,
      padding = { left = 1, right = 1 },
    })

    ins_left({
      function()
        return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      end,
      icon = "󰉖",
      color = { fg = colors.blue, gui = "bold" },
    })

    ins_left({
      function()
        local fname = vim.fn.expand("%:t")
        if fname == "" then
          return ""
        end
        local icon, _, _ = require("mini.icons").get("file", fname)
        return icon .. " " .. fname
      end,
      cond = conditions.buffer_not_empty,
      color = { fg = colors.magenta, gui = "bold" },
    })

    ins_left({
      "filesize",
      icon = "󰋊",
      cond = conditions.buffer_not_empty,
    })

    ins_left({
      function()
        local line = vim.fn.line(".")
        local col = vim.fn.virtcol(".")
        return string.format("Ln %d, Col %d", line, col)
      end,
      color = { fg = colors.fg, gui = "bold" },
    })

    ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

    -- mid separator
    ins_left({
      function()
        return "%="
      end,
    })

    ins_left({
      function()
        local buf_ft = vim.bo.filetype
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        for _, client in ipairs(clients) do
          local ft = client.config.filetypes
          if ft and vim.fn.index(ft, buf_ft) ~= -1 then
            return client.name
          end
        end
        return "No LSP"
      end,
      icon = "󰒓",
      color = { fg = "#ffffff", gui = "bold" },
    })

    ins_left({
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = {
        error = icons.diagnostics.BoldError,
        warn = icons.diagnostics.BoldWarning,
        info = icons.diagnostics.BoldInformation,
      },
      diagnostics_color = {
        error = { fg = colors.red },
        warn = { fg = colors.yellow },
        info = { fg = colors.cyan },
      },
    })

    -- ┤ Right side ├ --

    ins_right({
      "o:encoding",
      fmt = string.upper,
      cond = conditions.hide_in_width,
      color = { fg = colors.green, gui = "bold" },
    })

    ins_right({
      "fileformat",
      fmt = string.upper,
      icons_enabled = false,
      color = { fg = colors.green, gui = "bold" },
    })

    ins_right({
      function()
        local ok, lib = pcall(require, "auto-session.lib")
        if ok then
          local name = lib.current_session_name(true)
          if name and name ~= "" then
            return "󱑿 " .. name
          end
        end
        return ""
      end,
      color = { fg = colors.cyan, gui = "bold" },
    })

    ins_right({
      "branch",
      icon = icons.git.Branch,
      color = { fg = colors.violet, gui = "bold" },
    })

    ins_right({
      "diff",
      symbols = { added = icons.git.LineAdded, modified = icons.git.LineModified, removed = icons.git.LineRemoved },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    })

    ins_right({
      "copilot",
      show_colors = true,
      padding = { left = 1, right = 0 },
    })

    ins_right({
      function()
        return "▊"
      end,
      color = { fg = colors.blue },
      padding = { left = 1 },
    })

    lualine.setup(config)
  end,
}

return M
