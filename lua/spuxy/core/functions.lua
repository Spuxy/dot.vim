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
  return vim.uv.fs_stat(path)
end

-- Return telescope files command
M.project_files = function()
  local path = vim.uv.cwd() .. "/.git"
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

-- Smartly opens either git_files or find_files, depending on whether the working directory is
-- contained in a Git repo.
M.find_project_files = function(opts)
  opts = opts or {}
  local ok = pcall(builtin.git_files, opts)
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
