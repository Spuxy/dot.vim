local cmd = vim.cmd
local fn = vim.fn

local M = {}
--- Check if the minimum Neovim version is satisfied
--- Expects only the minor version, e.g. "9" for 0.9.1
---@param version number
---@return boolean
M.isNeovimVersionsatisfied = function(version)
	return version <= tonumber(vim.version().minor)
end

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

M.get_neopywal = function()
	local has_neopywal, neopywal_lualine = pcall(require, "neopywal.theme.plugins.lualine")
	if not has_neopywal then
		return
	end
	return neopywal_lualine
end

return M
