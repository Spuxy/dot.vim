# Plugin Decisions Log

Architectural decision record for plugin choices — why something was added, removed, or replaced.

---

## Active Decisions (refactor branch)

### Completion: nvim-cmp replaced by blink.cmp

- **Date**: 2025 (refactor branch)
- **Old**: nvim-cmp + cmp-nvim-lsp + cmp-buffer + cmp-path + cmp-luasnip + copilot-cmp
- **New**: blink.cmp (v1) + blink.compat (for luasnip + copilot sources)
- **Why**: blink.cmp is Rust-based, faster, fewer dependencies, built-in sources for LSP/path/snippets/buffer. Single plugin replaces 6. Actively maintained by saghen.
- **Files**: `completions/blink.lua`, `completions/lazydev.lua`

### Formatting: none-ls replaced by conform.nvim

- **Date**: 2025 (refactor branch)
- **Old**: none-ls.nvim (null-ls fork) — bundled formatters + linters in one LSP shim
- **New**: conform.nvim (formatters) + nvim-lint (linters)
- **Why**: none-ls injects formatters/linters as fake LSP clients — adds complexity, slower, harder to debug. conform.nvim calls formatters directly (no LSP overhead). nvim-lint runs linters on events. Cleaner separation of concerns.
- **Files**: `conform.lua`, `linters/nvim-lint.lua`, `defaults/tools.lua`

### Icons: nvim-web-devicons replaced by mini.icons

- **Date**: 2025 (refactor branch)
- **Old**: nvim-web-devicons
- **New**: nvim-mini/mini.icons with `package.preload` mock
- **Why**: mini.icons is lighter, part of the mini.nvim ecosystem. The `package.preload` trick makes all plugins that `require("nvim-web-devicons")` transparently use mini.icons instead. Zero config needed in downstream plugins.
- **Files**: `mini-icon.lua`

### Dashboard: alpha.nvim replaced by snacks.dashboard

- **Date**: 2025 (refactor branch)
- **Old**: alpha.nvim
- **New**: snacks.dashboard (part of snacks.nvim)
- **Why**: snacks.dashboard integrates with the rest of snacks (projects, recent files, git). One less standalone plugin. Supports terminal sections (kubectl, git status).
- **Files**: `snacks.lua`

### Notifications: nvim-notify replaced by snacks.notifier

- **Date**: 2025 (refactor branch)
- **Old**: rcarriga/nvim-notify
- **New**: snacks.notifier
- **Why**: snacks.notifier handles `vim.notify` out of the box. Removes a standalone dependency. Supports fancy style, positioning, animations.
- **Files**: `snacks.lua`

### Terminal: toggleterm replaced by snacks.terminal

- **Date**: 2025 (refactor branch)
- **Old**: akinsho/toggleterm.nvim
- **New**: snacks.terminal
- **Why**: snacks.terminal supports count-based instances (bottom vs float), integrates with snacks toggle system. One less plugin.
- **Files**: `snacks.lua` (keymaps: `<C-t>` bottom, `<C-y>`/`<C-\>` float)

### Word highlighting: illuminate replaced by snacks.words

- **Date**: 2025 (refactor branch)
- **Old**: RRethy/vim-illuminate
- **New**: snacks.words
- **Why**: snacks.words highlights LSP references under cursor. Same feature, fewer plugins.
- **Files**: `snacks.lua`

### Indent guides: indent-blankline replaced by snacks.indent + mini.indentscope

- **Date**: 2025 (refactor branch)
- **Old**: lukas-reineke/indent-blankline.nvim
- **New**: snacks.indent (static guides) + mini.indentscope (current scope animation)
- **Why**: Two focused tools instead of one monolith. snacks.indent draws ambient guide lines. mini.indentscope highlights only the scope under cursor. Complementary, not competing.
- **Files**: `snacks.lua`, `mini-indentscope.lua`

### Auto-pairs: nvim-autopairs replaced by mini.pairs

- **Date**: 2025 (refactor branch)
- **Old**: windwp/nvim-autopairs
- **New**: nvim-mini/mini.pairs
- **Why**: mini.pairs is simpler, lighter, part of mini.nvim ecosystem. Only active in insert mode (command/terminal disabled).
- **Files**: `mini-pairs.lua`

### Surround: nvim-surround replaced by mini.surround

- **Date**: 2025 (refactor branch)
- **Old**: kylechui/nvim-surround
- **New**: nvim-mini/mini.surround
- **Why**: Same ys/ds/cs keymaps, part of mini.nvim ecosystem. Muscle memory preserved.
- **Files**: `mini-surround.lua`

### Search/Replace: nvim-spectre replaced by grug-far.nvim

- **Date**: 2025 (refactor branch)
- **Old**: nvim-pack/nvim-spectre (required gsed on macOS)
- **New**: MagicDuck/grug-far.nvim
- **Why**: Spectre required `gsed` on macOS (GNU sed). grug-far uses ripgrep natively, no extra dependencies. Better UI, supports current word/file scoping.
- **Files**: `grug-far.lua`

### Breadcrumbs: navic removed, lspsaga symbols_in_winbar used instead

- **Date**: 2025 (refactor branch)
- **Old**: SmiteshP/nvim-navic
- **New**: lspsaga `symbols_in_winbar`
- **Why**: Lspsaga already provides winbar symbols with more features (click-to-jump, breadcrumb trail). Navic was redundant.
- **Files**: `lspsaga.lua`

### Commenting: comment.nvim removed

- **Date**: 2025 (refactor branch)
- **Old**: numToStr/Comment.nvim
- **New**: Neovim 0.10+ built-in gc/gb commenting
- **Why**: Native Neovim 0.10+ has `gc` (line comment) and `gb` (block comment) built-in. No plugin needed.

### Split/Join: treesj replaced by mini.splitjoin

- **Date**: 2025 (refactor branch)
- **Old**: Wansmer/treesj
- **New**: nvim-mini/mini.splitjoin
- **Why**: Part of mini.nvim ecosystem. Same toggle/split/join functionality.
- **Files**: `mini/splitjoin.lua`

### nvim-ufo removed — native treesitter folds

- **Date**: 2026-04-12
- **Old**: kevinhwang91/nvim-ufo + promise-async (2 plugins)
- **New**: Native `vim.treesitter.foldexpr()` in `core/options.lua`
- **Why**: Neovim 0.12 has `vim.treesitter.foldexpr()` and `vim.lsp.foldexpr()` built-in. ufo's treesitter+indent provider chain is now redundant. Native `foldtext = ""` (0.12+) shows first-line content in folds. `zR`/`zM` are native vim keymaps that work without ufo. snacks.statuscolumn already draws fold indicators. Lost features: fold preview popup (`zK` to peek inside a fold) — acceptable tradeoff for 2 fewer plugins.
- **Revert**: archived at `archive/ufo.lua`, re-add `spec("spuxy.ufo")` to init.lua and remove foldmethod/foldexpr/foldtext from `core/options.lua`
- **Files**: `core/options.lua`, `archive/ufo.lua`

### noice.nvim removed — native cmdline

- **Date**: 2026-04-12
- **Old**: folke/noice.nvim + MunifTanjim/nui.nvim (2 plugins)
- **New**: Native Neovim cmdline + snacks.notifier for notifications
- **Why**: Almost all noice features were already disabled: `notify: false` (snacks.notifier), `signature: false` (blink.cmp), `hover: false`, `progress: false`. The only active feature was the cmdline popup preset (cosmetic `:` and `/` popups). The config also referenced `cmp.entry.get_documentation` (stale nvim-cmp reference). Not worth 2 plugin dependencies for cmdline cosmetics. Notification history keymaps (`<leader>mna`, `<leader>mnd`) moved to snacks.notifier in `snacks.lua`.
- **Revert**: archived at `archive/noice.lua`, re-add `spec("spuxy.noice")` to init.lua
- **Files**: `snacks.lua`, `whichkey.lua`, `archive/noice.lua`

### Treesitter-context added — sticky scroll

- **Date**: 2026-04-12
- **Plugin**: nvim-treesitter/nvim-treesitter-context
- **Why**: VSCode has "sticky scroll" — pins the current function/class header at the top of the window. This is the treesitter equivalent. Helps orientation in deeply nested code without scrolling up. Purely additive, no conflicts.
- **Files**: `treesitter-context.lua`

### Treesitter textobjects expanded — move + swap + repeatable motions

- **Date**: 2026-04-12
- **What changed**: textobjects.move and textobjects.swap enabled alongside the existing textobjects.select. Repeatable motions added (`;`/`,` repeat last treesitter jump, also work with native `f`/`t`).
- **Why**: textobjects.select was the only active feature — move and swap were unused. `]f`/`[f` for jumping between functions and `<leader>xp`/`<leader>xP` for swapping arguments are standard treesitter features every config should have. Repeatable motions via `;`/`,` are native vim behavior extended to treesitter jumps.
- **Conflict resolution**: `[f`/`]f` conflicted with mini.bracketed's "files in directory" jump. Disabled `file` suffix in mini.bracketed — function navigation is more useful.
- **Files**: `treesitter-textobjects.lua`, `mini/bracketed.lua`

### File reorganization — mini plugins moved to `mini/` directory

- **Date**: 2026-04-12
- **Old**: `mini-pairs.lua`, `mini-surround.lua`, etc. at `lua/spuxy/` root
- **New**: `mini/pairs.lua`, `mini/surround.lua`, etc. in `lua/spuxy/mini/`
- **Why**: 10 mini-*.lua files cluttering the root directory. Grouping into `mini/` matches the existing pattern for other plugin groups (`lsp/`, `git/`, `debug/`, `completions/`). Each mini module stays in its own file for readability.
- **Spec paths**: Changed from `spec("spuxy.mini-pairs")` to `spec("spuxy.mini.pairs")` in init.lua.

---

## Kept / Not Migrated

### Telescope kept over snacks.picker

- **Date**: 2026-04
- **Status**: Keeping Telescope, snacks.picker disabled
- **Why**: Telescope ecosystem is mature (telescope-fzf-native, telescope-dap, project.nvim integrations). Migration to snacks.picker is possible future work but not worth the churn now. `picker = { enabled = false }` in snacks.lua.

### Telescope upgraded from 0.1.7 to master

- **Date**: 2026-04-12
- **Old**: `tag = "0.1.7"` — mid-2024 release, used deprecated treesitter APIs
- **New**: `branch = "master"` — latest with Neovim 0.12 compatibility
- **Why**: Pinned 0.1.7 broke on Neovim 0.12: preview errors from deprecated `vim.treesitter.get_query`, no syntax highlighting in previewer, deprecated `nvim_buf_set_option`. Master branch has all fixes. Also fixed: `opts` table was never applied (missing `telescope.setup(opts)` call in config function), duplicate `dependencies` key, stale packer-style `requires` syntax, global `opts` variable leak in `<leader>]` keymap.
- **Files**: `telescope.lua`

### Harpoon: upgraded from v1 to v2

- **Date**: 2026-04-12
- **Old**: ThePrimeagen/harpoon master (v1) — `require("harpoon.mark").add_file()` API
- **New**: ThePrimeagen/harpoon branch `harpoon2` — `harpoon:list():add()` API
- **Why**: v1 is unmaintained. v2 has cleaner API, per-project lists, ordered marks, prev/next cycling. `defaults/plugins.lua` had stale v2-style keymaps that would crash with v1 — resolved by actually upgrading.
- **Files**: `harpoon.lua`

### Oil.nvim added — filesystem editing as a buffer

- **Date**: 2026-04-12
- **Plugin**: stevearc/oil.nvim
- **Why**: Complements neo-tree (sidebar tree browser) with a different paradigm. Oil lets you edit the filesystem using normal vim motions — rename by editing text, delete by removing lines, save with `:w`. VSCode has inline rename in the explorer; oil goes further. `-` to go up is pure vim-vinegar muscle memory.
- **Coexistence**: No conflict with neo-tree. `<C-n>` opens neo-tree sidebar, `-` opens oil buffer.
- **Files**: `oil.lua`

### Kustomize.nvim added — Kubernetes Kustomize integration

- **Date**: 2026-04-12
- **Plugin**: Allaman/kustomize.nvim
- **Why**: Direct integration with the Kustomize workflow already used in this stack (K8s, Flux CD, ArgoCD). Build previews, resource listing, validation (kubeconform), deprecation checks (kubent) — all without leaving Neovim. Complements the existing YAML schema detection in `lsp/yaml/detect.lua`.
- **Files**: `kustomize.lua`

---

## Archived Plugins (in lua/spuxy/archive/)

Files moved to archive are not loaded. They exist as reference for possible future use.

| Plugin | File | Reason |
|--------|------|--------|
| alpha.nvim | alpha.lua | Replaced by snacks.dashboard |
| barbecue.nvim | barbecue.lua | Replaced by lspsaga symbols_in_winbar |
| nvim-cmp (old config) | blinkcmp.lua | Old blink config variant |
| breadcrumbs | breadcrumbs.lua | Replaced by lspsaga |
| ChatGPT.nvim | chatgpt.lua | Requires OpenAI token, not used |
| copilot.lua (old config) | copilot-lua.lua | Backup config, conflicts with active copilot.lua |
| dressing.nvim | dressing.lua | snacks.input handles vim.ui.input |
| go.nvim (old config) | go.lua | Restructured to lsp/go/ |
| guihua.lua | guihua.lua | go.nvim dependency, kept for reference |
| language settings | languages.lua | Restructured to lsp/<lang>/ |
| lsp_signature | lsp_signature.lua | Replaced by blink.cmp signature.enabled |
| old keymaps | mapping.lua, mappings.lua | Restructured to defaults/mappings/ |
| noice.nvim | noice.lua | Cmdline popup only feature left; not worth nui.nvim dep |
| none-ls | none-ls.lua | Replaced by conform + nvim-lint |
| nvim-ufo | ufo.lua | Replaced by native vim.treesitter.foldexpr() in 0.12 |
| nvim-notify | notify.lua | Replaced by snacks.notifier |
| overseer.nvim | overseer.lua | No keymaps configured, no way to invoke |
| nvim-dap-python (old) | python.lua | Restructured to debug/python/ |
| smart-splits (old) | smart-splits.lua | Active version at top level |
| substitute.nvim | substitute.lua | Empty config, no keymaps, does nothing |
| toggleterm | toggleterm.lua | Replaced by snacks.terminal |
| treesitter-autotag (old) | treesitter-autotag.lua | Now a dependency in treesitter.lua |
| old UI config | ui-old.lua, ui.lua.backup | Replaced by snacks + lualine |
