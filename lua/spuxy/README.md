# spuxy — Neovim Config Notes

## Architecture

- **Namespace:** `lua/spuxy/`
- **Plugin manager:** lazy.nvim
- **Entry point:** `init.lua` — calls `spec()` for every plugin, then `require("spuxy.lazy")`
- **`spec(item)`** is a global helper (defined in `core/launch.lua`) that appends `{ import = item }` to `LAZY_PLUGIN_SPEC`, which lazy.nvim reads in `lazy.lua`
- **Neovim version required:** 0.11+ (uses `vim.lsp.config()` / `vim.lsp.enable()` new API)

### Directory layout

```
lua/spuxy/
  core/           — keymaps, options, autocmds, functions, health
  defaults/       — tools.lua (LSP/formatters/linters), mappings/
  mini/           — mini.nvim modules (one file per module)
  completions/    — blink.cmp, lazydev
  lsp/            — lspconfig + per-language settings (go/, python/, c/, etc.)
  debug/          — nvim-dap + per-language debug configs
  git/            — gitsigns, neogit, fugitive, keymaps
  linters/        — nvim-lint
  colorschemes/   — tokyonight (active)
  ai/             — copilot, copilotchat
  snippets/       — custom luasnip snippets
  archive/        — disabled plugins kept for reference
```

---

## Requirements

External tools that must be present on `$PATH` before opening Neovim.
Mason auto-installs LSP servers, formatters, linters, and debuggers — but these
system-level prerequisites must be bootstrapped by Ansible (or manually).

<!-- BEGIN REQUIREMENTS — machine-readable, scraped by Ansible -->

### required

| tool | description | brew | apt |
|------|-------------|------|-----|
| neovim | Editor, version 0.11+ required | `neovim` | `neovim` |
| git | Version control | `git` | `git` |
| rg | Ripgrep — telescope, grug-far, live grep | `ripgrep` | `ripgrep` |
| fd | Find alternative — telescope file finder | `fd` | `fd-find` |
| fzf | Fuzzy finder — nvim-bqf dependency | `fzf` | `fzf` |
| node | Node.js — Mason, copilot, markdown-preview | `node` | `nodejs` |
| yarn | JS package manager — markdown-preview build | `yarn` | `yarn` |
| trash | Trash CLI — neo-tree delete-to-trash | `trash` | `trash-cli` |
| make | Build tool — telescope-fzf-native, luasnip jsregexp | `make` | `make` |
| gcc | C compiler — treesitter parser compilation | `gcc` | `gcc` |
| tree-sitter | Tree-sitter CLI >= 0.26.1 — parser compilation | | | `cargo install tree-sitter-cli` |
| curl | HTTP client — plenary.curl, yaml schema detection | `curl` | `curl` |
| unzip | Archive tool — Mason package extraction | `unzip` | `unzip` |
| tar | Archive tool — Mason package extraction | pre-installed | `tar` |
| gzip | Compression — Mason package extraction | pre-installed | `gzip` |

### optional_languages

| tool | description | brew | apt | install_cmd |
|------|-------------|------|-----|-------------|
| go | Go toolchain — gopls, delve, go.nvim | `go` | `golang` | |
| python3 | Python runtime — pyright, debugpy, nvim-lint | `python` | `python3` | |
| pip | Python packages — pylint, black, isort | included with python | `python3-pip` | |
| cargo | Rust toolchain — rust-analyzer, blink.cmp build | `rustup` | `rustup` | `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \| sh` |
| rustfmt | Rust formatter — not in Mason | | | `rustup component add rustfmt` |
| rust-analyzer | Rust LSP — not in Mason | | | `rustup component add rust-analyzer` |
| ruby | Ruby runtime — ruby_lsp, rubocop | `ruby` | `ruby-full` | |
| gem | Ruby packages — puppet-languageserver | included with ruby | included with ruby | |
| lua | Lua runtime — selene linter | `lua` | `lua5.4` | |

### optional_infra

| tool | description | brew | apt | install_cmd |
|------|-------------|------|-----|-------------|
| kubectl | Kubernetes CLI — dashboard context display | `kubectl` | `kubectl` | |
| kustomize | Kustomize CLI — kustomize.nvim build/list | `kustomize` | | |
| kubeconform | K8s manifest validator — kustomize.nvim validate | `kubeconform` | | `go install github.com/yannh/kubeconform/cmd/kubeconform@latest` |
| kubent | K8s deprecation checker — kustomize.nvim deprecations | | | `sh -c "$(curl -sSL https://git.io/install-kubent)"` |
| helm | Helm CLI — helm_ls language server | `helm` | `helm` | |
| terraform | Terraform CLI — terraformls language server | `terraform` | `terraform` | |
| ansible | Ansible CLI — ansiblels language server | `ansible` | `ansible` | |
| chezmoi | Dotfile manager — auto-apply on save | `chezmoi` | | `sh -c "$(curl -fsLS get.chezmoi.io)"` |

### optional_tools

| tool | description | brew | apt | install_cmd |
|------|-------------|------|-----|-------------|
| ipcalc | IP subnet calculator — :IPCalc command | `ipcalc` | `ipcalc` | |
| puppet-languageserver | Puppet LSP — not in Mason | | | `gem install puppet-editor-services` |
| ruby-debug-ide | Ruby debugger — not in Mason | | | `gem install ruby-debug-ide debase` |
| bacon | Rust background compiler | | | `cargo install bacon` |
| snyk | Security scanner | `snyk` | | `npm install -g snyk` |
| sphinx-lint | RST linter | | | `pip install sphinx-lint` |

### mason_auto_installed

These are auto-installed by Mason on first launch — no manual action needed.
Listed here for Ansible to verify they exist after bootstrap.

**LSP servers:** cssls, html, bashls, dockerls, jsonls, helm_ls, yamlls, ansiblels, gopls, pyright, lua_ls, rust_analyzer, clangd, ruby_lsp

**Formatters:** clang-format, goimports, gofumpt, prettier, stylua, shfmt, isort, ruff, black, rubocop, yamlfmt

**Linters:** hadolint, revive, selene, shellcheck, yamllint, pylint, rubocop, markdownlint-cli2, rstcheck

**Debuggers:** debugpy, delve, bash-debug-adapter, codelldb

**Treesitter parsers:** bash, c, cmake, cpp, css, dockerfile, go, hcl, html, javascript, json, jsonc, lua, markdown, markdown_inline, query, python, regex, ruby, rust, terraform, toml, tsx, typescript, vim, yaml

<!-- END REQUIREMENTS -->

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

## Completion engine — blink.cmp (active)

Rust-based completion engine, replacing nvim-cmp. Faster, built-in sources, actively maintained.

Active stack: `blink.cmp` + `blink.compat` + `luasnip` (for custom snippets).

### Sources

| Source | What it provides |
|--------|-----------------|
| `lsp` | LSP completions (triggers after 2 chars, 0 on manual `<C-space>`) |
| `path` | File path completions |
| `snippets` | Built-in blink snippet engine |
| `luasnip` | Custom luasnip snippets via blink.compat |
| `buffer` | Words from open buffers (min 5 chars, max 5 items) |
| `lazydev` | Neovim Lua API completions (lua ft only, priority +100) |
| `emoji` | Emoji completions via blink.compat + allaman/emoji.nvim |

### Keymaps

| Key | Action |
|-----|--------|
| `<C-space>` | Show / toggle documentation |
| `<C-e>` | Hide menu |
| `<CR>` | Accept selected item |
| `<Tab>` / `<S-Tab>` | Next / prev item, or jump snippet placeholder |
| `<C-j>` / `<C-k>` | Next / prev item |
| `<C-f>` / `<C-b>` | Scroll documentation up / down |

### LSP capabilities

`lspconfig.lua` uses `require("blink.cmp").get_lsp_capabilities()` — single call, no manual merging needed.

### Cmdline completion

Enabled with `preset = "cmdline"` — blink handles `:` command completion automatically.

> **nvim-cmp** (`completions/cmp.lua`) is kept on disk but no longer loaded. Safe to delete if you are confident you won't switch back.

---

## GitHub org — mini.nvim

All mini.* plugins use the **`nvim-mini`** GitHub org, NOT `echasnovski`:
```lua
"nvim-mini/mini.icons"   -- correct
"nvim-mini/mini.ai"      -- correct
"echasnovski/mini.icons" -- WRONG — old URL (redirects but causes issues)
```

---

## Treesitter-context — sticky scroll (VSCode-style)

Pins the current function/class/block header at the top of the window so you always
know where you are in deeply nested code. Exactly like VSCode's "sticky scroll" feature.

- Shows up to 3 context lines at the top
- Follows cursor position — updates as you move
- Separated by a `─` line from the actual code
- Hidden in small windows (< 20 lines)

| Key | Action |
|-----|--------|
| `gC` | Jump up to the sticky context header |

---

## Treesitter textobjects — select, move, swap

### Move — jump between code structures with `[`/`]`

All move keymaps are **repeatable with `;` and `,`** (just like `f`/`t`).

| Key | Action |
|-----|--------|
| `]f` / `[f` | Next / prev function start |
| `]F` / `[F` | Next / prev function end |
| `]a` / `[a` | Next / prev argument |
| `]l` / `[l` | Next / prev loop |

> These are added to the jumplist — use `<C-o>` to jump back.

### Swap — reorder function parameters

| Key | Action |
|-----|--------|
| `<leader>xp` | Swap parameter with next |
| `<leader>xP` | Swap parameter with previous |

### Repeatable motions

`;` repeats the last treesitter move forward, `,` repeats backward.
This also applies to native `f`/`t`/`F`/`T` — all use the same repeat keys.

---

## mini.ai — Extended text objects

Extends Neovim's built-in `a`/`i` system. All objects work with every operator (`d`, `c`, `y`, `v`, `=`, `gq`, etc.) and support **counts** (`d2a)` = delete 2nd outer parens).

### Improved built-ins (work from anywhere inside, not just adjacent)

| Key | Object |
|-----|--------|
| `i(`/`a(` `i[`/`a[` `i{`/`a{` | Inside/around brackets |
| `ib`/`ab` | Any bracket — matches `()`, `[]`, `{}` (closest) |
| `iq`/`aq` | Any quote — matches `"`, `'`, `` ` `` |

### New objects

| Key | Object |
|-----|--------|
| `if`/`af` | Function **call** — `daf` deletes `foo(args)` including the name |
| `ia`/`aa` | **Argument** — `cia` changes one arg, handles commas cleanly |
| `it`/`at` | HTML/XML **tag** — `dat` deletes `<div>...</div>` |
| `i?`/`a?` | **Prompted** — asks which delimiter to use interactively |

### Treesitter objects (wired up via `gen_spec.treesitter`)

| Key | Object |
|-----|--------|
| `iF`/`aF` | Inside/around **function definition** |
| `ic`/`ac` | Inside/around **class** |
| `io`/`ao` | Inside/around **block / if / loop / conditional** |

### Jumping

Prefix any object with `[` or `]` to jump to the previous/next occurrence:

| Key | Action |
|-----|--------|
| `]a` / `[a` | Next/prev argument |
| `]f` / `[f` | Next/prev function call |
| `]F` / `[F` | Next/prev function definition |
| `]o` / `[o` | Next/prev block/conditional |

---

## mini.indentscope — Scope-aware indent highlighting

Complements `snacks.indent` — they serve different purposes:

| | snacks.indent | mini.indentscope |
|---|---|---|
| What | Static guide lines for **every** indent level | Highlighted line for **current scope only** |
| When | Always visible | Follows cursor |

### How it works

- Draws a distinct `│` line along the scope your cursor is currently inside
- `try_as_border = true` — scope includes the surrounding delimiter lines (e.g. `function`/`end`)
- Auto-disabled in special buffers (lazy, mason, neo-tree, Trouble, etc.)
- Animation is disabled for instant rendering (snacks already provides the ambient guide lines)

### Keymaps (built-in)

| Key | Action |
|-----|--------|
| `[i` | Jump to **top** of current scope |
| `]i` | Jump to **bottom** of current scope |
| `ii`/`ai` | Text object — inside/around current indent scope |

> `vii` selects everything inside the current block. `dai` deletes it including the border lines.

---

## mini.move — Move lines and selections

Moves the current line (normal mode) or visual selection in any direction without cut/paste.

| Key | Action |
|-----|--------|
| `<M-h>` | Move left |
| `<M-j>` | Move down |
| `<M-k>` | Move up |
| `<M-l>` | Move right |

Works in both **normal** and **visual** mode. In visual mode, the entire selection moves and stays selected.

---

## mini.bracketed — `[`/`]` jumps for everything

Adds consistent forward/backward navigation with `[` and `]` for many targets:

| Key | Jumps between |
|-----|---------------|
| `[b` / `]b` | Buffers |
| `[c` / `]c` | Comments |
| `[x` / `]x` | Conflict markers |
| `[f` / `]f` | Files in directory |
| `[i` / `]i` | Indent level changes |
| `[j` / `]j` | Jumplist entries |
| `[l` / `]l` | Location list entries |
| `[o` / `]o` | Oldfiles |
| `[q` / `]q` | Quickfix entries |
| `[u` / `]u` | Undo history states |
| `[w` / `]w` | Windows |
| `[y` / `]y` | Yank history |

> Treesitter (`[t`/`]t`) and diagnostic (`[d`/`]d`) jumps are **disabled** — already covered by nvim-treesitter-textobjects and the custom `[e`/`]e`/`[w`/`]w` keymaps.

---

## mini.trailspace — Trailing whitespace

- Highlights trailing whitespace in red while editing
- Automatically trims trailing whitespace **and** blank lines at end of file on `BufWritePre`
- Skips special buffers (terminals, scratch, etc.)

No keymaps needed — fully automatic.

---

## mini.hipatterns — Inline pattern highlighting

Highlights hex color codes inline with their actual color as the background.

Examples: `#ff6600` `#00bfff` `#a8e6cf` — each renders with its color visible directly in the buffer.

Active in all normal file buffers automatically on open. No keymaps needed.

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

---

## Harpoon 2 — fast file jumping

Mark up to 4 files and jump to them instantly by number. No fuzzy finding, no tree — just
muscle-memory jumps to the files you're actively working on.

### Keymaps

| Key | Action |
|-----|--------|
| `<S-m>` | Mark current file (add to harpoon list) |
| `<leader>0` | Toggle harpoon quick menu |
| `<leader>1` | Jump to harpoon file 1 |
| `<leader>2` | Jump to harpoon file 2 |
| `<leader>3` | Jump to harpoon file 3 |
| `<leader>4` | Jump to harpoon file 4 |
| `[h` / `]h` | Previous / next harpoon mark |

> Marks persist per-project across sessions. The quick menu (`<leader>0`) lets you reorder
> and remove marks.

---

## Oil.nvim — filesystem as a buffer

Edit your filesystem using normal vim motions. Open a directory, rename files by editing text,
delete by removing lines, create by adding lines. Save with `:w` to apply all changes.

Coexists with neo-tree: use neo-tree as a sidebar tree browser, oil for quick bulk edits.

### Keymaps

| Key | Action |
|-----|--------|
| `-` | Open parent directory (oil) |
| `<leader>fo` | Open oil in floating window |
| `<CR>` | Open file / enter directory |
| `<C-v>` | Open in vertical split |
| `<C-s>` | Open in horizontal split |
| `<C-p>` | Preview file |
| `<C-c>` | Close oil |
| `g.` | Toggle hidden files |
| `g\` | Toggle trash |
| `gs` | Change sort |

> Oil replaces netrw as the default file explorer. `-` from any buffer goes up to the parent
> directory — pure vim-vinegar workflow.

---

## Kustomize.nvim — Kubernetes Kustomize integration

Build, validate, and navigate Kustomize resources directly in Neovim.

**Requires in `$PATH`:** `kustomize`, `kubeconform` (validation), `kubent` (deprecation checks)

### Keymaps (`<leader>k`)

| Key | Action |
|-----|--------|
| `<leader>kb` | Build manifests |
| `<leader>kk` | List kinds |
| `<leader>kl` | List resources |
| `<leader>kp` | Print resources |
| `<leader>kv` | Validate manifests |
| `<leader>kd` | Check deprecations |
