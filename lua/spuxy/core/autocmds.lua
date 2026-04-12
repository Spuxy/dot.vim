local api = vim.api

-- Toggle window maximize: saves exact sizes of all windows, restores them on second press
local _maximize_state = nil -- { win, sizes = { [winid] = {width, height} } }

vim.api.nvim_create_user_command("WindowsMaximize", function()
  local cur_win = vim.api.nvim_get_current_win()

  -- If we have a saved state and the same window is still maximized, restore
  if _maximize_state and _maximize_state.win == cur_win then
    for winid, dims in pairs(_maximize_state.sizes) do
      if vim.api.nvim_win_is_valid(winid) then
        vim.api.nvim_win_set_width(winid, dims.width)
        vim.api.nvim_win_set_height(winid, dims.height)
      end
    end
    _maximize_state = nil
    return
  end

  -- Save all window sizes before maximizing
  local sizes = {}
  for _, winid in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_is_valid(winid) then
      sizes[winid] = {
        width = vim.api.nvim_win_get_width(winid),
        height = vim.api.nvim_win_get_height(winid),
      }
    end
  end
  _maximize_state = { win = cur_win, sizes = sizes }

  vim.cmd("wincmd |")
  vim.cmd("wincmd _")
end, { desc = "Toggle maximize current window" })

-- Auto-create parent directories when saving a file to a new path
api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    local file = args.match
    -- Skip URL-like paths (e.g. scp://, fugitive://)
    if file:match("^%w+://") then return end
    local dir = vim.fn.fnamemodify(vim.uv.fs_realpath(file) or file, ":p:h")
    if dir ~= "" and not vim.uv.fs_stat(dir) then
      vim.fn.mkdir(dir, "p")
    end
  end,
  desc = "Auto-create parent directories on save",
})

-- Refresh buffers when Neovim regains focus (catches external git checkouts etc.)
api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  callback = function()
    -- Don't checktime on scratch/nofile buffers
    if vim.bo.buftype ~= "nofile" then vim.cmd("checktime") end
  end,
  desc = "Refresh buffers on focus regain",
})

-- Quit when only sidebar windows remain (neo-tree, aerial)
local sidebar_fts = { ["neo-tree"] = true, aerial = true }
api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local wins = vim.api.nvim_tabpage_list_wins(0)
    -- If only one window left, let neo-tree handle its own auto-close
    if #wins == 1 and vim.bo[vim.api.nvim_win_get_buf(wins[1])].filetype ~= "aerial" then
      return
    end
    local remaining = vim.tbl_filter(function(w)
      if not vim.api.nvim_win_is_valid(w) then return false end
      local ft = vim.bo[vim.api.nvim_win_get_buf(w)].filetype
      return not sidebar_fts[ft]
    end, wins)
    if #remaining == 0 then
      if #vim.api.nvim_list_tabpages() > 1 then
        vim.cmd.tabclose()
      else
        vim.cmd.qall()
      end
    end
  end,
  desc = "Quit when only sidebar windows remain",
})

-- Make gf understand require() / dofile() / loadfile() in Lua files (LunarVim approach)
api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    ---@diagnostic disable-next-line: assign-type-mismatch
    vim.opt_local.include = [[\v<((do|load)file|require|reload)[^'"]*['"\zs[^'"]+]]
    vim.opt_local.includeexpr = "substitute(v:fname,'\\.','/','g')"
    vim.opt_local.suffixesadd:prepend(".lua")
    vim.opt_local.suffixesadd:prepend("/init.lua")
    for _, p in ipairs(vim.api.nvim_list_runtime_paths()) do
      vim.opt_local.path:append(p .. "/lua")
    end
  end,
  desc = "gf understands require() paths in Lua",
})

api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "highlight on yank",
})

api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Disable New Line Comment",
})

api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    local buf = args.buf
    -- Don't restore in gitcommit buffers (would land on stale line)
    if vim.tbl_contains({ "gitcommit" }, vim.bo[buf].filetype) then return end
    local mark = api.nvim_buf_get_mark(buf, '"')
    local lcount = api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "go to last loc when opening a buffer",
})

api.nvim_create_autocmd("FileType", {
  pattern = {
    "grug-far",
    "help",
    "qf",
    "query",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
  desc = "close certain windows with q",
})

api.nvim_create_autocmd("FileType", {
  pattern = {
    "man",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "ZQ", { buffer = event.buf, silent = true })
  end,
  desc = "quit man page Neovim",
})

-- Equalize window sizes when terminal is resized
api.nvim_create_autocmd("VimResized", {
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
  desc = "Equalize window sizes on terminal resize",
})

-- Ensure editorconfig settings take precedence after FileType detection
api.nvim_create_autocmd("FileType", {
  callback = function(args)
    if vim.F.if_nil(vim.b.editorconfig, vim.g.editorconfig) then
      local ok, editorconfig = pcall(require, "editorconfig")
      if ok then editorconfig.config(args.buf) end
    end
  end,
  desc = "Re-apply editorconfig after FileType",
})

local chezmoi_path = vim.fn.resolve(vim.fn.expand("~/.local/share/chezmoi"))
api.nvim_create_autocmd("BufWritePost", {
  pattern = {
    chezmoi_path .. "/**/*", -- files in subdirectories
  },
  callback = function()
    vim.notify("Applying chezmoi changes", vim.log.levels.INFO)
    vim.system({ "chezmoi", "apply", "-k" })
  end,
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*Dockerfile*",
  callback = function()
    vim.bo.filetype = "dockerfile"
  end,
})

vim.api.nvim_create_user_command("IPCalc", function(opts)
  local word

  -- Check if called from visual mode
  if opts.range > 0 then
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.fn.getline(start_pos[2], end_pos[2])

    -- Handle single line selection
    if #lines == 1 then
      lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
    else
      -- Multi-line selection (take first line for now)
      lines[1] = string.sub(lines[1], start_pos[3])
    end

    word = lines[1]
  else
    -- Get the WORD under the cursor (includes special chars like /)
    word = vim.fn.expand("<cWORD>")
  end

  -- Check if the word looks like an IP address with optional CIDR notation
  -- Matches: 192.168.1.1 or 192.168.1.0/24
  if not word:match("^%d+%.%d+%.%d+%.%d+/?%d*$") then
    vim.notify("No valid IP address under cursor or selected", vim.log.levels.WARN)
    return
  end

  local output = vim.fn.system("ipcalc " .. vim.fn.shellescape(word))

  if vim.v.shell_error ~= 0 then
    vim.notify("ipcalc command failed", vim.log.levels.ERROR)
    return
  end

  -- Display output in a floating window
  local lines = vim.split(output, "\n")
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local width = 80
  local height = 10
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Open floating window
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " ipcalc: " .. word .. " ",
    title_pos = "center",
  })

  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype = "nofile"

  vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { nowait = true })
  vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", ":close<CR>", { nowait = true })
end, {
  range = true, -- Enable range support
  desc = "Run ipcalc on IP address under cursor or visual selection",
})
