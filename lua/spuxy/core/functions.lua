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

return M
