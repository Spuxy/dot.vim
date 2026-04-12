local M = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    gitbrowse = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        {
          pane = 2,
          section = "terminal",
          cmd = "kubectl config get-contexts -oname",
          height = 5,
          padding = 1,
        },
        { section = "keys", gap = 1, padding = 1 },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        {
          pane = 2,
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = "startup" },
      },
    },
    explorer = { enabled = false },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = false }, -- keeping Telescope for now
    notifier = {
      enabled = true,
      style = "fancy",
      top_down = false,
      gap = 1,
    },
    rename = { enabled = true },
    terminal = { enabled = true },
    scratch = { enabled = true },
    quickfile = { enabled = true },
    zen = { enabled = true },
    dim = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = {
      enabled = true,
      folds = {
        open = true, -- show chevron on open folds (VSCode-style)
        git_hl = true, -- colour the fold indicator with git diff colours
      },
    },
    toggle = { enabled = true },
    words = { enabled = true },
  },
  config = function(_, opts)
    require("snacks").setup(opts)

    -- Built-in option toggles
    Snacks.toggle.line_number():map("<leader>Tn")
    Snacks.toggle.option("list", { name = "Hidden Chars" }):map("<leader>Th")
    Snacks.toggle.option("signcolumn", { on = "yes", off = "no", name = "Sign Column" }):map("<leader>Tl")
    Snacks.toggle.option("virtualedit", { on = "all", off = "block", name = "Virtual Edit" }):map("<leader>Tv")
    Snacks.toggle.option("spell", { name = "Spell" }):map("<leader>Ts")
    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>Tw")
    Snacks.toggle.option("cursorline", { name = "Cursorline" }):map("<leader>Tc")
    -- Snacks feature toggles
    Snacks.toggle.inlay_hints():map("<leader>TI")
    Snacks.toggle.diagnostics():map("<leader>Td")
    Snacks.toggle.indent():map("<leader>Ti")
    Snacks.toggle.words():map("<leader>TW")
    Snacks.toggle.dim():map("<leader>TD")
    Snacks.toggle.scroll():map("<leader>TS")
    Snacks.toggle.zen():map("<leader>TZ")
    Snacks.toggle.zoom():map("<leader>Tz")
    -- Custom toggles
    Snacks.toggle({
      name = "Color Column",
      get = function()
        return vim.api.nvim_get_option_value("colorcolumn", {}) ~= ""
      end,
      set = function(state)
        vim.api.nvim_set_option_value("colorcolumn", state and "79" or "", {})
      end,
    }):map("<leader>TO")
    Snacks.toggle({
      name = "Virtual Text",
      get = function()
        return vim.diagnostic.config().virtual_text ~= false
      end,
      set = function(state)
        vim.diagnostic.config({ virtual_text = state })
      end,
    }):map("<leader>Tt")
    Snacks.toggle({
      name = "Inline Blame",
      get = function()
        return require("gitsigns.config").config.current_line_blame
      end,
      set = function(state)
        require("gitsigns").toggle_current_line_blame(state)
      end,
    }):map("<leader>Tb")
    -- Terminal (count separates instances: 1=bottom, 2=float)
    vim.keymap.set({ "n", "t" }, "<C-t>", function()
      Snacks.terminal.toggle(nil, { count = 1, win = { position = "bottom", height = 0.3 } })
    end, { desc = "Bottom Terminal" })
    vim.keymap.set({ "n", "t" }, "<C-y>", function()
      Snacks.terminal.toggle(nil, { count = 2, win = { position = "float" } })
    end, { desc = "Float Terminal" })
    vim.keymap.set({ "n", "t" }, [[<C-\>]], function()
      Snacks.terminal.toggle(nil, { count = 2, win = { position = "float" } })
    end, { desc = "Float Terminal" })
    -- Scratch
    vim.keymap.set("n", "<leader>.", function()
      Snacks.scratch()
    end, { desc = "Toggle Scratch Buffer" })
    vim.keymap.set("n", "<leader>S", function()
      Snacks.scratch.select()
    end, { desc = "Select Scratch Buffer" })
  end,
}

return M
