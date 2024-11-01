local utils = require("spuxy.core.functions")
local M = {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
        create_autocmd = false
    },
    config = function(_, opts)
        local win = ""
        if utils.isNeovimVersionsatisfied(9) then
            win = "WinResized"
        else
            win = "WinScrolled"
        end
        vim.opt.updatetime = 200
        require("barbecue").setup(opts)
        -- https://github.com/utilyre/barbecue.nvim?tab=readme-ov-file#-recipes
        vim.api.nvim_create_autocmd({
            win, -- or WinResized on NVIM-v0.9 and higher
            "BufWinEnter",
            "CursorHold",
            "InsertLeave",
            -- include this if you have set `show_modified` to `true`
            -- "BufModifiedSet",
          }, {
            group = vim.api.nvim_create_augroup("barbecue.updater", {}),
            callback = function()
              require("barbecue.ui").update()
            end,
          })
    end
}


function M.config()
end

return M