local utils = require("spuxy.core.functions")
local event = ""
if utils.isNeovimVersionsatisfied(10) then
	event = "LspAttach"
else
	event = "BufReadPre"
end
local M = {
	"Wansmer/symbol-usage.nvim",
	event = event, -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
	config = function()
		require("symbol-usage").setup()
	end,
}

return M