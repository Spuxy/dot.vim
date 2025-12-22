local M = {}

vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]

M.defaults = {
  {
    name = "BufferKill",
    fn = function()
      require("spuxy.core.functions").buf_kill "bd"
    end,
  },
  {
    name = "CustomFinder",
    fn = function()
      require("spuxy.core.functions").find_project_files({ previewer = false })
    end,
  },
  {
    name = "ToggleFormatOnSave",
    fn = function()
      require("lvim.core.autocmds").toggle_format_on_save()
    end,
  },
  {
    name = "LvimDocs",
    fn = function()
      local documentation_url = "https://www.lunarvim.org/docs/beginners-guide"
      if vim.fn.has "mac" == 1 or vim.fn.has "macunix" == 1 then
        vim.fn.execute("!open " .. documentation_url)
      elseif vim.fn.has "win32" == 1 or vim.fn.has "win64" == 1 then
        vim.fn.execute("!start " .. documentation_url)
      elseif vim.fn.has "unix" == 1 then
        vim.fn.execute("!xdg-open " .. documentation_url)
      else
        vim.notify "Opening docs in a browser is not supported on your OS"
      end
    end,
  },
}
--
-- function M.load(collection)
--   local common_opts = {}
--   local force = true
--   for _, cmd in pairs(collection) do
--     local opts = vim.tbl_deep_extend("force", common_opts, cmd.opts or {})
--     vim.api.nvim_create_user_command(cmd.name, cmd.fn, opts, force)
--   end
-- end
--
function M.load(collection)
  for _, cmd in pairs(collection) do
    local opts = cmd.opts or {}
    vim.api.nvim_create_user_command(cmd.name, cmd.fn, opts) -- <- last `true` is "force"
  end
end

return M
