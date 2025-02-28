local M = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim",              -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = {
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    default_component_configs = {
      indent = {
        with_markers = false,
      },
      name = {
        highlight_opened_files = true,
      },
    },
    popup_border_style = "rounded",
    enable_git_status = true,
    filesystem = {
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time
        --               -- the current file is changed while the tree is open.
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      commands = {
        -- Override delete to use trash instead of rm
        delete = function(state)
          local path = state.tree:get_node().path
          vim.fn.system({ "trash", vim.fn.fnameescape(path) })
          require("neo-tree.sources.manager").refresh(state.name)
        end,
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          local utils = require("spuxy.core.functions")
          if utils.getOS() == "Darwin" then
            vim.api.nvim_command("silent !open -g " .. path)
          elseif utils.getOS() == "Linux" then
            -- Mam pro to vylepseni, udelat alias ktery bude univerzal `open` a bude otevirat na zaklade file extension
            vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
          else
            vim.notify("Could not determine OS", vim.log.levels.ERROR)
          end
        end,
      },
    },
    window = {
      position = "left",
      width = 30,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ["o"] = "system_open",
        ["d"] = "noop", -- unbind delete
        ["dd"] = "delete", -- bind delete to new mapping

        ["C"] = "close_node",
        ["z"] = "close_all_nodes",

        ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
        ["l"] = "focus_preview",

        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",

        ["a"] = {
          "add",
          config = {
            show_path = "none",
          },
        },
        ["A"] = "add_directory",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy",

        -- ["/"] = "filter_on_submit",
        ["/"] = "fuzzy_finder",
        ["D"] = "fuzzy_finder_directory",
        ["f"] = "filter_on_submit",
        ["<C-x>"] = "clear_filter",

        ["t"] = "open_tabnew",
        ["w"] = "open_with_window_picker",
        ["s"] = "open_split",
        ["v"] = "open_vsplit",
        ["<space>"] = {
          "toggle_node",
          nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
        },
      },
    },
  },
  config = function(_, opts)
    -- Nefunguji
    vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

    require("neo-tree").setup(opts)
  end,
}

return M
