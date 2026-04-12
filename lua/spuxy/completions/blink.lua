local M = {
  "saghen/blink.cmp",
  event = "InsertEnter",
  dependencies = {
    { "L3MON4D3/LuaSnip" }, -- used via snippets.preset = 'luasnip'
    { "giuxtaposition/blink-cmp-copilot" },
  },
  version = "v1.*",
  opts = {
    fuzzy = { implementation = "prefer_rust_with_warning" },
    keymap = {
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },

      ["<Tab>"] = {
        function(cmp)
          return cmp.select_next()
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = {
        function(cmp)
          return cmp.select_prev()
        end,
        "snippet_backward",
        "fallback",
      },

      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },

      ["<C-f>"] = { "scroll_documentation_up", "fallback" },
      ["<C-b>"] = { "scroll_documentation_down", "fallback" },
    },
    sources = {
      per_filetype = {
        lua = { inherit_defaults = true, "lazydev" },
      },
      default = { "lsp", "path", "snippets", "buffer", "lazydev", "copilot" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100, -- show at a higher priority than lsp
        },
        lsp = {
          min_keyword_length = function(ctx)
            -- trigger immediately on trigger characters (e.g. ".") or manual invoke
            if ctx.trigger.kind == "trigger_character" or ctx.trigger.kind == "manual" then
              return 0
            end
            return 1
          end,
          score_offset = 0,
        },
        path = {
          min_keyword_length = 0,
        },
        snippets = {
          preset = "luasnip",
          min_keyword_length = 2,
          should_show_items = function(ctx)
            return ctx.trigger.initial_kind ~= "trigger_character" and not require("blink.cmp").snippet_active()
          end,
        },
        buffer = {
          min_keyword_length = 5,
          max_items = 5,
        },
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100,
          async = true,
        },
      },
    },
    cmdline = {
      keymap = {
        preset = "cmdline",
      },
      completion = {
        list = { selection = { preselect = false } },
        menu = { auto_show = true },
      },
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
        treesitter_highlighting = true,
        window = { border = "rounded" },
      },
      list = {
        selection = { preselect = false, auto_insert = true },
      },
      trigger = {
        show_on_insert_on_trigger_character = true,
        show_on_accept_on_trigger_character = true,
      },
      menu = {
        border = "rounded",
        draw = {
          columns = { { "label", "label_description", gap = 1 }, { "kind_icon" } },
        },
      },
    },
    -- experimental auto-brackets support
    -- completion = { accept = { auto_brackets = { enabled = true } } },

    signature = {
      enabled = true,
      window = { border = "rounded" },
    },
  },
  opts_extend = { "sources.default" },
  config = function(_, opts)
    require("blink.cmp").setup(opts)
  end,
}

return M
