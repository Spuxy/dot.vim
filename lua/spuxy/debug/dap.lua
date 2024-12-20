local utils = require("spuxy.core.functions")
local M = {
  -- DAP (Debug Adapter Protocol) for Go
  "mfussenegger/nvim-dap",
  keys = {
    { "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>db", function() require("dap").step_back() end, desc = "Step Back" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run To Cursor" },
    { "<leader>dd", function() require("dap").disconnect() end, desc = "Disconnect" },
    { "<leader>dg", function() require("dap").session() end, desc = "Get Session" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>du", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle Repl" },
    { "<leader>ds", function() require("dap").continue() end, desc = "Start" },
    { "<leader>dS", function() require("dap").continue({ before = utils.get_args }) end, desc = "Run with Args" },
    { "<leader>dq", function() require("dap").close() end, desc = "Quit" },
    { "<leader>dU", function() require("dapui").toggle({ reset = true }) end, desc = "Toggle UI" },
    { "<leader>dE", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" } },
    { "<leader>dK", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    { "<leader>dC", function() require('telescope').extensions.dap.configurations() end, desc = "Configurations" },
  },
}

return M
