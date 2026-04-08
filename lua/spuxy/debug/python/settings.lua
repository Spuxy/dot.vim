local M = {
  "mfussenegger/nvim-dap-python",
  keys = {
    {
      "<leader>dPt",
      function()
        require("dap-python").test_method()
      end,
      desc = "Debug Method",
      ft = "python",
    },
    {
      "<leader>dPc",
      function()
        require("dap-python").test_class()
      end,
      desc = "Debug Class",
      ft = "python",
    },
    {
      "<leader>dPs",
      function()
        require("dap-python").debug_selection()
      end,
      desc = "Debug Selection",
      ft = "python",
    },
  },
  config = function()
    local path = require("mason-registry").get_package("debugpy"):get_install_path()
    require("dap-python").setup(path .. "/venv/bin/python")
  end,
}

return M
