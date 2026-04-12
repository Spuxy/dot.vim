-- treesitter — syntax highlighting, indent, incremental selection, parsers
--
-- Neovim 0.11+ has native treesitter highlight/indent.
-- nvim-treesitter plugin handles parser installation and auto_install.

local defaults = require("spuxy.defaults.tools")

local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "RRethy/nvim-treesitter-endwise",
    "windwp/nvim-ts-autotag",
    {
      "nvim-mini/mini.ai",
      event = { "BufReadPre", "BufNewFile" },
      opts = function()
        local ai = require("mini.ai")
        return {
          n_lines = 500,
          custom_textobjects = {
            F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
            c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
            o = ai.gen_spec.treesitter({
              a = { "@block.outer", "@conditional.outer", "@loop.outer" },
              i = { "@block.inner", "@conditional.inner", "@loop.inner" },
            }),
          },
        }
      end,
    },
  },
  build = ":TSUpdate",
  config = function()
    -- Install parsers from defaults/tools.lua
    -- NOTE: :checkhealth shows "is not in runtimepath" — this is an upstream
    -- nvim-treesitter bug (trailing slash mismatch in health.lua:99). Parsers
    -- load and work correctly; the healthcheck comparison is wrong.
    require("nvim-treesitter").setup()
    local installed = require("nvim-treesitter").get_installed()
    local installed_set = {}
    for _, p in ipairs(installed) do installed_set[p] = true end
    local to_install = {}
    for _, p in ipairs(defaults.treesitter) do
      if not installed_set[p] then
        table.insert(to_install, p)
      end
    end
    if #to_install > 0 then
      require("nvim-treesitter").install(to_install)
    end

    -- Enable treesitter highlight and indent for all buffers
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
      callback = function(args)
        local ok = pcall(vim.treesitter.start, args.buf)
        if ok then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    -- Autotag (HTML/JSX auto-close)
    require("nvim-ts-autotag").setup()

    -- Incremental selection keymaps (manual since nvim-treesitter no longer provides them)
    vim.keymap.set("n", "<leader>ss", function()
      require("nvim-treesitter.incremental_selection").init_selection()
    end, { desc = "Init selection" })
    -- Fallback: if incremental_selection module doesn't exist, use native
    local ok_inc = pcall(require, "nvim-treesitter.incremental_selection")
    if not ok_inc then
      -- Use native treesitter node selection as fallback
      vim.keymap.set("n", "<leader>ss", function()
        vim.cmd("normal! v")
        vim.treesitter.get_node()
      end, { desc = "Init selection" })
    end

    -- Replace nvim-treesitter's markdown injection query with a safe version that
    -- avoids the set-lang-from-info-string! predicate (crashes Neovim 0.11+ on nil
    -- nodes). Uses explicit @injection.language capture instead.
    vim.treesitter.query.set("markdown", "injections", [[
      (fenced_code_block
        (info_string
          (language) @injection.language)
        (code_fence_content) @injection.content
        (#set! injection.include-children))
    ]])
  end,
}

return M
