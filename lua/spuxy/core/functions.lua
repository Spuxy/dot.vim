local cmd = vim.cmd
local fn = vim.fn

local _, builtin = pcall(require, "telescope.builtin")

local M = {}
---Return OS
---@return string
M.getOS = function()
  local sysname = vim.uv.os_uname().sysname
  if sysname == "Darwin" then
    return "Darwin"
  elseif sysname == "Linux" then
    -- NixOS identifies as Linux; check /etc/os-release
    local f = io.open("/etc/os-release", "r")
    if f then
      local content = f:read("*a")
      f:close()
      if content:find("NixOS") then
        return "NixOS"
      end
    end
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

--- Duplicate current file as copy-{filename} in the same directory and open it
M.duplicate_file = function()
  local src = vim.fn.expand("%:p")
  if src == "" then
    vim.notify("No file to duplicate", vim.log.levels.WARN)
    return
  end

  local dir  = vim.fn.fnamemodify(src, ":h")
  local name = vim.fn.fnamemodify(src, ":t")
  local dst  = dir .. "/copy-" .. name

  -- avoid overwriting an existing copy
  if vim.uv.fs_stat(dst) then
    vim.notify("Already exists: " .. dst, vim.log.levels.WARN)
    return
  end

  local ok, err = vim.uv.fs_copyfile(src, dst)
  if not ok then
    vim.notify("Duplicate failed: " .. (err or "unknown error"), vim.log.levels.ERROR)
    return
  end

  vim.cmd("edit " .. vim.fn.fnameescape(dst))
  vim.notify("Duplicated → copy-" .. name, vim.log.levels.INFO)
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
