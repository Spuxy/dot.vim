# spuxy — Neovim Config Notes

## Architecture

- **Namespace:** `lua/spuxy/`
- **Plugin manager:** lazy.nvim
- **Entry point:** `init.lua` — calls `spec()` for every plugin, then `require("spuxy.lazy")`
- **`spec(item)`** is a global helper (defined in `core/launch.lua`) that appends `{ import = item }` to `LAZY_PLUGIN_SPEC`, which lazy.nvim reads in `lazy.lua`
- **Neovim version required:** 0.11+ (uses `vim.lsp.config()` / `vim.lsp.enable()` new API)

---

## Single source of truth — `defaults/tools.lua`

All installable tools are declared here. Three consumers read from it:
- `mason-lspconfig.lua` — installs LSP servers + all formatters + all linters via mason-tool-installer
- `treesitter.lua` — installs parsers via TSUpdate
- `debug/mason.lua` — installs DAP adapters via mason-nvim-dap

**When adding a new language, update all four sections in `defaults/tools.lua`:**
`lsp_servers`, `formatters`, `linters`, `treesitter` (and `debuggers` if needed).

---

## Tools NOT installed by Mason (manage manually)

These must be available on `$PATH` but are intentionally excluded from Mason:

| Tool | Language | How to install |
|------|----------|----------------|
| `rustfmt` | Rust | `rustup component add rustfmt` |
| `rust-analyzer` | Rust | `rustup component add rust-analyzer` |
| `bacon` | Rust | `cargo install bacon` — background compiler, not a linter |
| `snyk` | Security | https://docs.snyk.io/snyk-cli/install-or-update-the-snyk-cli |
| `sphinx-lint` | RST | `pip install sphinx-lint` |
| `puppet-languageserver` | Puppet | `gem install puppet-editor-services` or bundled with Puppet Agent |
| `ruby-debug-ide` + `debase` | Ruby (debugger) | `gem install ruby-debug-ide debase` — no Mason package available |

> **Rule:** if a tool is not in the [Mason registry](https://mason-registry.dev/registry/list),
> do NOT add it to `defaults/tools.lua`. Conform and nvim-lint find tools on `$PATH` automatically.

---

## LSP Settings Files — Convention

Each `lsp/<lang>/settings.lua` returns the **full server opts table** passed directly to
`vim.lsp.config(server, opts)`. Do NOT wrap in an extra `settings = ...` layer at the call site.

```lua
-- lsp/lspconfig.lua (correct)
gopls = go_settings          -- go_settings = { settings = { gopls = {...} } }
clangd = c_settings          -- c_settings  = { cmd = {...}, init_options = {...} }
yamlls = yaml_settings       -- yaml_settings = { capabilities = {...}, settings = {...} }

-- WRONG — double-nesting (was the bug before refactor)
gopls = { settings = go_settings }
```

### Per-server structure notes

| Server | Settings key | Notes |
|--------|-------------|-------|
| `gopls` | `settings.gopls` | gopls reads under its own name |
| `lua_ls` | `settings.Lua` | capital L, all config lives here |
| `rust_analyzer` | `settings["rust-analyzer"]` | hyphenated key |
| `pyright` | `settings.python` | |
| `bashls` | `settings.bashIde` + top-level `filetypes` | |
| `clangd` | `cmd`, `init_options`, `filetypes` — no `settings` key | |
| `yamlls` | top-level `capabilities` + `settings.yaml` | capabilities must not be inside `settings` |

---

## Mason — known constraints

- **Requires Neovim 0.11+** for the `vim.lsp.config()` / `vim.lsp.enable()` API used in `lspconfig.lua`
- Mason is set up **once** via `opts` in `lsp/mason.lua` (lazy.nvim auto-calls `mason.setup(opts)`)
- `mason-lspconfig.lua` must **not** call `require("mason").setup()` again — it overrides the config
- Mason loads as a **dependency** of mason-lspconfig, so it loads at startup regardless of any `event`

### Package name gotchas

| Wrong (DAP adapter name) | Correct (Mason package name) |
|--------------------------|------------------------------|
| `python` | `debugpy` |
| `cppdbg` | `cpptools` |
| `bash` | `bash-debug-adapter` |

---

## Completion engine — nvim-cmp (active)

blink.cmp spec exists (`completions/blink.lua`) but is **commented out** in `init.lua`.
Active stack: `nvim-cmp` + `cmp-nvim-lsp` + `luasnip`.

`lspconfig.lua` uses `cmp_nvim_lsp.default_capabilities()` — if you switch to blink,
change the `dependencies` and capabilities line in `lspconfig.lua` to:
```lua
dependencies = { "saghen/blink.cmp" },
-- and in config:
capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
```

CMP menu format: `fields = { "abbr", "menu" }` — icon + kind name on the right, colorized
per kind via `menu_hl_group = "CmpItemKind" .. kind_name`.

---

## GitHub org — mini.nvim

All mini.* plugins use the **`nvim-mini`** GitHub org, NOT `echasnovski`:
```lua
"nvim-mini/mini.icons"   -- correct
"nvim-mini/mini.ai"      -- correct
"echasnovski/mini.icons" -- WRONG — old URL (redirects but causes issues)
```

---

## Markdown rendering — render-markdown.nvim (active)

`markdown.lua` is the active renderer. `markview.nvim` (`markview.lua`) is kept as an archived
alternative but commented out in `init.lua`.

### Why render-markdown was previously disabled (and how it was fixed)

The original crash was **not** in render-markdown itself — it was in nvim-treesitter's markdown
injection query calling the `set-lang-from-info-string!` predicate on a nil node (Neovim 0.11+).

**Fix in `treesitter.lua`:** Replace the broken query with a safe custom one:
```lua
vim.treesitter.query.set("markdown", "injections", [[
  (fenced_code_block
    (info_string (language) @injection.language)
    (code_fence_content) @injection.content
    (#set! injection.include-children))
]])
```
This preserves fenced code block highlighting (including inside LSP hover docs) without using
the crashing predicate. **Do not remove this block** — nvim-treesitter's bundled query still
has the bug.

### LSP hover doc rendering

- `noice.lua`: `lsp.override.vim.lsp.util.stylize_markdown = true` patches the markdown renderer
  to use treesitter. `hover.enabled = false` — render-markdown handles hover windows natively.
- `noice.lua`: `lsp_doc_border = true` — rounded border on hover/signature floats.
- `render-markdown`: `overrides.buftype.nofile.enabled = true` — attaches to lspsaga hover_doc
  windows (which use `markdown` filetype + `nofile` buftype).
- `:Lspsaga hover_doc` renders code blocks with syntax highlighting via the treesitter
  injection query above.

---

## Neovim 0.11 compatibility shims

These patches live in plugin configs to bridge API removals in Neovim 0.11+:

### yaml-companion.nvim — `yamlcompanion.lua`
`client.workspace_did_change_configuration` was removed in Neovim 0.11. yaml-companion calls it
in its `on_attach` to update the active schema. Fixed by shimming it back via `lspconfig.on_attach`:
```lua
on_attach = function(client, _bufnr)
  if not client.workspace_did_change_configuration then
    client.workspace_did_change_configuration = function(settings)
      client:notify("workspace/didChangeConfiguration", { settings = settings or {} })
    end
  end
end
```

### nvim-lint — `linters/nvim-lint.lua`
Neovim 0.11 rejects diagnostics with `end_lnum = -1` / `end_col = -1` (linters that don't
report end positions). Fixed by patching `vim.diagnostic.set` to clamp negative values:
```lua
vim.diagnostic.set = function(ns, bufnr, diagnostics, opts)
  for _, d in ipairs(diagnostics) do
    if d.end_lnum == nil or d.end_lnum < 0 then d.end_lnum = d.lnum end
    if d.end_col == nil or d.end_col < 0 then d.end_col = d.col end
  end
  orig_set(ns, bufnr, diagnostics, opts)
end
```
Remove this shim once nvim-lint releases a fix (`:Lazy update nvim-lint` to check).

---

## Folding — nvim-ufo + snacks.statuscolumn

- `foldcolumn = '0'` in options — snacks.statuscolumn owns the fold indicator column entirely
- `foldlevel = 99` + `foldlevelstart = 99` — ufo requires large values so all folds start open
- `fillchars`: `foldopen:▾,foldclose:▸` — must be single display-cell characters (nerd font
  multi-cell chevrons cause E1511)
- ufo provider: `{ 'treesitter', 'indent' }` — no LSP foldingRange capability needed
- Keymaps: `zR` open all, `zM` close all

---

## Flash.nvim — native vim motions preserved

`s`, `S`, `r`, `R`, `f`, `t`, `F`, `T` are all **native vim**. Flash is mapped to:
- `<leader>j` — jump anywhere on screen with labels
- `<leader>J` — treesitter node selection with labels
- `/` / `?` — search is automatically enhanced with flash labels (always active, no binding needed)

`modes.char.enabled = false` — disables f/t/F/T interception (was breaking `ct`, `dt`, etc.)

---

## Window keymaps (`<leader>w`)

`<leader>w` follows the industry standard (LazyVim, AstroNvim, LunarVim all use it for windows).
`<leader>ws` is a subgroup for split-specific actions.

| Key | Action |
|-----|--------|
| `<leader>wc` | Close current window |
| `<leader>wm` | Maximize window |
| `<leader>w=` | Equalize all window sizes |
| `<leader>wv` | Vertical split |
| `<leader>wh` | Horizontal split |
| `<leader>wsr` | Rotate split down/right |
| `<leader>wsR` | Rotate split up/left |
| `<leader>wsk` | Resize up |
| `<leader>wsj` | Resize down |
| `<leader>wsl` | Resize right |
| `<leader>wsh` | Resize left |
| `<leader>wH/J/K/L` | Swap buffer with adjacent split (smart-splits) |

> Quick shortcuts `<leader>v` and `<leader>h` also open vertical/horizontal splits directly.
> `<A-h/j/k/l>` resize splits without a leader key (smart-splits).

---

## smart-splits.nvim — window navigation + WezTerm integration

Replaces plain `<C-w>hjkl` with smart-splits for seamless Neovim ↔ WezTerm pane navigation.

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move cursor between splits (or WezTerm panes when configured) |
| `<A-h/j/k/l>` | Resize current split directionally |
| `<leader>wH/J/K/L` | Swap buffer with adjacent split |

**WezTerm integration (one-time setup)** — add to `wezterm.lua`:
```lua
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config)
```
Then uncomment `multiplexer_integration = "wezterm"` in `lua/spuxy/smart-splits.lua`.

**Important:** `spec("spuxy.smart-splits")` must appear **before** `require("spuxy.lazy")` in
`init.lua` — specs registered after lazy initializes are silently ignored.

---

## Bufferline — `buf_kill` timing issue

`buf_kill` is defined as `local function buf_kill(...)` **before** the `M` table in `bufferline.lua`.
This is required because lazy.nvim captures `opts` early — if defined as `function M.buf_kill()`
after the table, `close_command` closures see `nil`. `M.buf_kill = buf_kill` at the bottom
exposes it for `:BufferKill`.

---

## Debug Keymaps (`<leader>d`)

All keymaps work across every language unless noted.

### Breakpoints

| Key | Action | Notes |
|-----|--------|-------|
| `<leader>dt` | Toggle breakpoint | Normal on/off breakpoint |
| `<leader>dB` | Conditional breakpoint | Prompts for a condition (e.g. `i == 500`, `err != nil`) — only pauses when true |
| `<leader>dl` | Log point | Prompts for a message — prints to debug console without pausing execution |

### Execution control

| Key | Action |
|-----|--------|
| `<leader>dc` | Continue / Start |
| `<leader>dC` | Run to cursor |
| `<leader>dS` | Run with args |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>du` | Step out |
| `<leader>db` | Step back |
| `<leader>dp` | Pause |
| `<leader>dd` | Disconnect |
| `<leader>dq` | Quit session |

### UI & Inspection

| Key | Action |
|-----|--------|
| `<leader>dU` | Toggle debug UI panel |
| `<leader>dr` | Toggle REPL |
| `<leader>dE` | Evaluate expression (normal + visual selection) |
| `<leader>dK` | Hover variable value under cursor |
| `<leader>df` | List all DAP configurations (via Telescope) |
| `<leader>dg` | Get current session info |

### Python only (`<leader>dP`)

Only available in `.py` files.

| Key | Action |
|-----|--------|
| `<leader>dPt` | Debug test method under cursor |
| `<leader>dPc` | Debug test class under cursor |
| `<leader>dPs` | Debug selected code block |

### Debugger adapter coverage

| Language | Adapter | Installed by |
|----------|---------|--------------|
| Go | delve (via nvim-dap-go) | Mason |
| Python | debugpy (via nvim-dap-python) | Mason |
| Rust | codelldb | Mason |
| C | codelldb | Mason (same adapter as Rust) |
| C++ | codelldb | Mason (same adapter as Rust) |
| Shell | bash-debug-adapter | Mason |
| Ruby | ruby-debug-ide + debase | `gem install ruby-debug-ide debase` |

> **Go/delve note:** pass `args = { "--check-go-version=false" }` in dap-go config to suppress
> version mismatch errors when Mason's delve lags behind the installed Go version.

---

## Buffer keymaps (`<leader>b`)

| Key | Action |
|-----|--------|
| `<leader>bb` | Pick buffer (jump) |
| `<leader>bf` | Find buffer (Telescope with preview) |
| `<leader>bd` | Delete current buffer (smart — switches to prev, doesn't close window) |
| `<leader>bj` | Previous buffer |
| `<leader>bk` | Next buffer |
| `<leader>bp` | Toggle pin |
| `<leader>bP` | Delete all non-pinned buffers |
| `<leader>be` | Pick which buffer to close |
| `<leader>bo` | Close all other buffers |
| `<leader>bl` | Close all buffers to the left |
| `<leader>br` | Close all buffers to the right |
| `<leader>bW` | Save without formatting (noautocmd) |
| `<leader>bD` | Sort by directory |
| `<leader>bL` | Sort by extension |

---

## Tab keymaps (`<leader>a`)

Neovim tabs are **window layouts** (separate split arrangements), not file tabs.
Use buffers + bufferline for file switching. Use tabs for separate workspaces.

| Key | Action |
|-----|--------|
| `<leader>an` | New empty tab |
| `<leader>aN` | New tab with current file |
| `<leader>ac` | Close current tab |
| `<leader>ao` | Close all other tabs |
| `<leader>aj` | Next tab |
| `<leader>ak` | Previous tab |
| `<leader>ah` | Move tab left |
| `<leader>al` | Move tab right |
