local M = {
  "saghen/blink.cmp",
  event = "InsertEnter",
  dependencies = {
    { "allaman/emoji.nvim"},
    { "saghen/blink.compat" },
    {
      "saghen/blink.compat",
      optional = true,
      opts = {},
    },
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
      default = { "lsp", "path", "snippets", "buffer", "lazydev", "emoji" },
      providers = {
        emoji = {
          name = "emoji",
          module = "blink.compat.source",
          -- overwrite kind of suggestion
          transform_items = function(ctx, items)
            local kind = require("blink.cmp.types").CompletionItemKind.Text
            for i = 1, #items do
              items[i].kind = kind
            end
            return items
          end,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100, -- show at a higher priority than lsp
        },
        lsp = {
          min_keyword_length = function(ctx)
            return ctx.trigger.kind == "manual" and 0 or 2 -- trigger when invoking with shortcut
          end,
          score_offset = 0,
        },
        path = {
          min_keyword_length = 0,
        },
        snippets = {
          min_keyword_length = 2,
          should_show_items = function(ctx)
            return ctx.trigger.initial_kind ~= "trigger_character" and not require("blink.cmp").snippet_active()
          end,
        },
        buffer = {
          min_keyword_length = 5,
          max_items = 5,
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
        show_on_insert_on_trigger_character = false,
        show_on_accept_on_trigger_character = false,
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

    -- experimental signature help support
    -- signature = { enabled = true }
  },
  opts_extend = {
    "sources.default",
    "sources.compat",
  },
  config = function(_, opts)
    -- setup compat sources and provider
    local enabled = opts.sources.default
    for _, source in ipairs(opts.sources.compat or {}) do
      opts.sources.providers[source] = vim.tbl_deep_extend(
        "force",
        { name = source, module = "blink.compat.source" },
        opts.sources.providers[source] or {}
      )
      if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
        table.insert(enabled, source)
      end
    end

    -- check if we need to override symbol kinds
    for _, provider in pairs(opts.sources.providers or {}) do
      ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
      if provider.kind then
        require("blink.cmp.types").CompletionItemKind[provider.kind] = provider.kind
        ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
        local transform_items = provider.transform_items
        ---@param ctx blink.cmp.Context
        ---@param items blink.cmp.CompletionItem[]
        provider.transform_items = function(ctx, items)
          items = transform_items and transform_items(ctx, items) or items
          for _, item in ipairs(items) do
            item.kind = provider.kind or item.kind
          end
          return items
        end
      end
    end

    require("blink.cmp").setup(opts)
  end,
}

return M
