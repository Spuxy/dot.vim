local M = {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")

    -- codelldb handles Rust, C, and C++ via LLDB
    local ok, codelldb_path = pcall(function()
      return require("mason-registry").get_package("codelldb"):get_install_path()
    end)

    if ok then
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_path .. "/extension/adapter/codelldb",
          args = { "--port", "${port}" },
        },
      }

      local codelldb_config = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      dap.configurations.c = codelldb_config
      dap.configurations.cpp = codelldb_config
      dap.configurations.rust = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
    end
  end,
}

return M
