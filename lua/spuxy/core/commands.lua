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
      require("spuxy.bufferline").buf_kill("bd")
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
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      vim.notify(
        string.format("Format on save %s", vim.g.disable_autoformat and "disabled" or "enabled"),
        vim.log.levels.INFO,
        { title = "conform.nvim" }
      )
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
