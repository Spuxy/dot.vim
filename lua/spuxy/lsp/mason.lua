local M = {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
  build = function()
    pcall(function()
      require("mason-registry").refresh()
    end)
  end,
  opts = {
    ui = {
      check_outdated_packages_on_open = true,
      width = 0.8,
      height = 0.9,
      border = "rounded",
      keymaps = {
        toggle_package_expand = "<CR>",
        install_package = "i",
        update_package = "u",
        check_package_version = "c",
        update_all_packages = "U",
        check_outdated_packages = "C",
        uninstall_package = "X",
        cancel_installation = "<C-c>",
        apply_language_filter = "<C-f>",
      },
    },
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
    pip = {
      upgrade_pip = false,
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
  },
}

return M
