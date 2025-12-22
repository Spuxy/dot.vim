local cmd = vim.cmd
local fn = vim.fn

local _, builtin = pcall(require, "telescope.builtin")

local M = {}
---Return OS
---@return string
M.getOS = function()
  local handle = io.popen("uname -s")
  if handle == nil then
    vim.notify("Error while opening handler", vim.log.levels.ERROR)
    return ""
  end
  local uname = handle:read("*a")
  handle:close()
  uname = uname:gsub("%s+", "")
  if uname == "Darwin" then
    return "Darwin"
  elseif uname == "NixOS" then
    return "NixOS"
  elseif uname == "Linux" then
    return "Linux"
  else
    return ""
  end
end

--- Check if the minimum Neovim version is satisfied
--- Expects only the minor version, e.g. "9" for 0.9.1
---@param version number
---@return boolean
M.isNeovimVersionsatisfied = function(version)
	return version <= tonumber(vim.version().minor)
end

---checks if a command is available
---@param command string
---@return boolean
M.isExecutableAvailable = function(command)
  return vim.fn.executable(command) == 1
end

---notify
---@param message string
---@param level integer
---@param title string
M.notify = function(message, level, title)
	local notify_options = {
	  title = title,
	  timeout = 2000,
	}
	vim.api.nvim_notify(message, level, notify_options)
end

-- Check if a variable is not empty nor nil
---@param s any
---@return boolean
M.isNotEmpty = function(s)
  return s ~= nil and s ~= ""
end

--- Check if path exists
---@param path string
---@return boolean
M.path_exists = function(path)
  return vim.loop.fs_stat(path)
end

-- Return telescope files command
M.project_files = function()
  local path = vim.loop.cwd() .. "/.git"
  if M.path_exists(path) then
    local show_untracked = vim.g.config.plugins.telescope.show_untracked_files
    return "lua require('telescope.builtin').git_files({ show_untracked = " .. tostring(show_untracked) .. " })"
  else
    return "Telescope find_files"
  end
end

-- Return file browser command
M.file_browser = function()
  if vim.g.config.plugins.lf.enable then
    return "Lf"
  end
  return "Telescope file_browser grouped=true"
end

-- toggle quickfixlist
M.toggle_qf = function()
  local windows = fn.getwininfo()
  if windows == nil then
    return
  end
  local qf_exists = false
  for _, win in pairs(windows) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    cmd("cclose")
    return
  end
  if M.isNotEmpty(fn.getqflist()) then
    cmd("copen")
  end
end

-- toggle colorcolumn
M.toggle_colorcolumn = function()
  local value = vim.api.nvim_get_option_value("colorcolumn", {})
  if value == "" then
    M.notify("Enable colocolumn", 1, "functions.lua")
    vim.api.nvim_set_option_value("colorcolumn", "79", {})
  else
    M.notify("Disable colocolumn", 1, "functions.lua")
    vim.api.nvim_set_option_value("colorcolumn", "", {})
  end
end

-- move over a closing element in insert mode
M.escapePair = function()
  local closers = { ")", "]", "}", ">", "'", '"', "`", "," }
  local line = vim.api.nvim_get_current_line()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local after = line:sub(col + 1, -1)
  local closer_col = #after + 1
  local closer_i = nil
  for i, closer in ipairs(closers) do
    local cur_index, _ = after:find(closer)
    if cur_index and (cur_index < closer_col) then
      closer_col = cur_index
      closer_i = i
    end
  end
  if closer_i then
    vim.api.nvim_win_set_cursor(0, { row, col + closer_col })
  else
    vim.api.nvim_win_set_cursor(0, { row, col + 1 })
  end
end

-- @author kikito
-- @see https://codereview.stackexchange.com/questions/268130/get-list-of-buffers-from-current-neovim-instance
-- currently not used
function M.get_listed_buffers()
  local buffers = {}
  local len = 0
  for buffer = 1, vim.fn.bufnr("$") do
    if vim.fn.buflisted(buffer) == 1 then
      len = len + 1
      buffers[len] = buffer
    end
  end

  return buffers
end

function M.map(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

--- Get current buffer size
M.get_buf_size = function()
	local cbuf = vim.api.nvim_get_current_buf()
	local bufinfo = vim.tbl_filter(function(buf)
		return buf.bufnr == cbuf
	end, vim.fn.getwininfo(vim.api.nvim_get_current_win()))[1]
	if bufinfo == nil then
		return { width = -1, height = -1 }
	end
	return { width = bufinfo.width, height = bufinfo.height }
end


-- Get args from user input
-- @param config table
-- @return table
M.get_args = function(config)
	local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
	config = vim.deepcopy(config)
	---@cast args string[]
	config.args = function()
	  local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
	  return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
	end
	return config
end

-- Get neopywal lualine theme if neopywal is installed
--- @return table|nil
M.get_neopywal = function()
	local has_neopywal, neopywal_lualine = pcall(require, "neopywal.theme.plugins.lualine")
	if not has_neopywal then
    M.notify("neopywal is not installed", vim.log.levels.WARN, "Spuxy")
		return
	end
	return neopywal_lualine
end

M.mason_install = function(tools)

	local has_mason_registry, mason_registry = pcall(require, "mason-registry")
	if not has_mason_registry then
		return
	end

	local function install_ensured()
	  for _, tool in ipairs(tools) do
		local p = mason_registry.get_package(tool)
		if not p:is_installed() then
		  p:install()
		end
	  end
	end
	if mason_registry.refresh then
	  mason_registry.refresh(install_ensured)
	else
	  install_ensured()
	end
end


M.buf_kill = function(kill_command, bufnr, force)
  kill_command = kill_command or "bd"

  local bo = vim.bo
  local api = vim.api
  local fmt = string.format
  local fn = vim.fn

  if bufnr == 0 or bufnr == nil then
    bufnr = api.nvim_get_current_buf()
  end

  local bufname = api.nvim_buf_get_name(bufnr)

  if not force then
    local choice
    if bo[bufnr].modified then
      choice = fn.confirm(fmt([[Save changes to "%s"?]], bufname), "&Yes\n&No\n&Cancel")
      if choice == 1 then
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd("w")
        end)
      elseif choice == 2 then
        force = true
      else return
      end
    elseif api.nvim_get_option_value("buftype", { buf = 0 }) == "terminal" then
      choice = fn.confirm(fmt([[Close "%s"?]], bufname), "&Yes\n&No\n&Cancel")
      if choice == 1 then
        force = true
      else
        return
      end
    end
  end
    -- Get list of windows IDs with the buffer to close
  local windows = vim.tbl_filter(function(win)
    return api.nvim_win_get_buf(win) == bufnr
  end, api.nvim_list_wins())

  if force then
    kill_command = kill_command .. "!"
  end

  -- Get list of active buffers
  local buffers = vim.tbl_filter(function(buf)
    return api.nvim_buf_is_valid(buf) and bo[buf].buflisted
  end, api.nvim_list_bufs())

  -- If there is only one buffer (which has to be the current one), vim will
  -- create a new buffer on :bd.
  -- For more than one buffer, pick the previous buffer (wrapping around if necessary)
  if #buffers > 1 and #windows > 0 then
    for i, v in ipairs(buffers) do
      if v == bufnr then
        local prev_buf_idx = i == 1 and #buffers or (i - 1)
        local prev_buffer = buffers[prev_buf_idx]
        for _, win in ipairs(windows) do
          api.nvim_win_set_buf(win, prev_buffer)
        end
      end
    end
  end

  -- Check if buffer still exists, to ensure the target buffer wasn't killed
  -- due to options like bufhidden=wipe.
  if api.nvim_buf_is_valid(bufnr) and bo[bufnr].buflisted then
    vim.cmd(string.format("%s %d", kill_command, bufnr))
  end
end

-- Smartly opens either git_files or find_files, depending on whether the working directory is
-- contained in a Git repo.
M.find_project_files = function(opts)
  opts = opts or {}
  local ok = pcall(builtin.git_files, opts)

  print(builtin)
  if not ok then
    builtin.find_files(opts)
  end
end


-- Check if editing git commit message
-- @return boolean
M.is_editing_git_commit = function()
  return string.find(vim.api.nvim_buf_get_name(0), "COMMIT_EDITMSG")
end

return M
