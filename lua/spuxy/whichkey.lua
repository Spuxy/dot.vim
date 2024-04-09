local M = {
  "folke/which-key.nvim",
}

function M.config()
  local mappings = {
    q = { "<cmd>confirm q<CR>", "Quit" },
    e = { "<cmd>Lexplore <CR>", "Explore" },
    H = { "<cmd>nohlsearch<CR>", "NOHL" },
    [";"] = { "<cmd>tabnew | terminal<CR>", "Term" },
    v = { "<cmd>vsplit<CR>", "Vertical Split" },
    h = { "<cmd>split<CR>", "Horizontal Split" },
    y = { "<cmd>Telescope projects<CR>", "Projects" },
    b = {
      name = "Buffers",
      b = { "<cmd>BufferLinePick<cr>", "Jump" },
      f = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
      j = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
      k = { "<cmd>BufferLineCycleNext<cr>", "Next" },
      W = { "<cmd>noautocmd w<cr>", "Save without formatting (noautocmd)" },
      -- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
      e = { "<cmd>BufferLinePickClose<cr>", "Pick which buffer to close" },
      h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
      l = { "<cmd>BufferLineCloseRight<cr>", "Close all to the right" },
      D = { "<cmd>BufferLineSortByDirectory<cr>", "Sort by directory" },
      L = { "<cmd>BufferLineSortByExtension<cr>", "Sort by language" },
    },
    d = {
      name = "Debug",
      t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
      b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
      c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
      C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
      d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
      g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
      i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
      o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
      u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
      p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
      s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
      q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
      U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
    },
    f = { name = "Find" },
    g = {
      name = "Git",
      g = { "<cmd>lua require 'lvim.core.terminal'.lazygit_toggle()<cr>", "Lazygit" },
      j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
      k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
      l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
      p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
      R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
      s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
      u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
      o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
      C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
      d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Git Diff" },
    },
    l = {
      name = "LSP",
      -- a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      a = { "<cmd>:Lspsaga code_action<cr>", "Code Action" },
      d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
      w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
      f = { "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>", "Format" },
      i = { "<cmd>LspInfo<cr>", "Info" },
      -- I = { "<cmd>Mason<cr>", "Mason Info" },
      I = { "<cmd>lua require('spuxy.lspconfig').toggle_inlay_hints()<cr>", "Hints" },
      j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
      k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
      l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
      q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
      e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
      h = { "<cmd>:Lspsaga hover_doc<cr>", "Hover Doc" },
      H = { "<cmd>:Lspsaga hover_doc ++keep<cr>", "Hover Doc + Keep" },
      s = { "<cmd>:Lspsaga signature_help<cr>", "Signature" },
      O = { "<cmd>Telescope lsp_document_symbols<cr>", "Workspace Symbols" },
      o = { "<cmd>:Lspsaga outline<cr>", "Outline Symbols" },
      p = {
        name = "Peek",
        p = { "<cmd>:Lspsaga peek_definition<cr>", "Preview" },
        d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", "Definition" },
        f = { ":Lspsaga finder<CR>", "Finder" },
        -- i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", "Implementation" },
      },
    },
    n = {
      name = "Todos",
      n = { "<cmd>TodoTrouble<cr>", "Term" },
      f = { "<cmd>TodoTelescope<cr>", "Telescope" },
    },
    p = { name = "Plugins" },
    t = { name = "Test" },
    a = {
      name = "Tab",
      n = { "<cmd>$tabnew<cr>", "New Empty Tab" },
      N = { "<cmd>tabnew %<cr>", "New Tab" },
      o = { "<cmd>tabonly<cr>", "Only" },
      h = { "<cmd>-tabmove<cr>", "Move Left" },
      l = { "<cmd>+tabmove<cr>", "Move Right" },
    },
    T = { name = "Treesitter" },
    s = {
      name = "Search",
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
      f = { "<cmd>Telescope find_files<cr>", "Find File" },
      h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
      H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
      M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
      r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
      R = { "<cmd>Telescope registers<cr>", "Registers" },
      t = { "<cmd>Telescope live_grep<cr>", "Text" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      C = { "<cmd>Telescope commands<cr>", "Commands" },
      l = { "<cmd>Telescope resume<cr>", "Resume last search" },
      p = {
        "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
        "Colorscheme with Preview",
      },
    },
  }

  local which_key = require "which-key"
  which_key.setup {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
    window = {
      border = "rounded",
      position = "bottom",
      padding = { 2, 2, 2, 2 },
    },
    ignore_missing = true,
    show_help = false,
    show_keys = false,
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  }

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
  }

  which_key.register(mappings, opts)
end

return M
