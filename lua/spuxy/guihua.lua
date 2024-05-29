local M = {
  "ray-x/guihua.lua",
  run = "cd lua/fzy && make",
}

function M.config()
  require("guihua").setup({})
end

return M
