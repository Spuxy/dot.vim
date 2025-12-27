local functions = require("spuxy.core.functions")
local default = require("spuxy.defaults.plugins")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Remap space as leader key
-- Must be before lazy
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ml", "<cmd>Lazy<cr>")

require("lazy").setup({
  spec = LAZY_PLUGIN_SPEC,
  install = {
     colorscheme = { "default", "darkplus", "tokyonight", "habamax" },
     missing = false
    },
  ui = {
    border = "rounded",
  },
  checker = { enabled = not functions.is_editing_git_commit(), frequency = 86400 }, -- automatically check for plugin updates every 24h
  change_detection = {
    enabled = true,
    notify = true,
  },
  debug = false,
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = default.plugins.lazy.disable_neovim_plugins },
  },
})
