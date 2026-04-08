local wk = require("which-key")
local utils = require("spuxy.core.functions")

-- DAP (Debug Adapter Protocol) keymaps
wk.add({
  -- Breakpoints & Control
  { "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
  { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional Breakpoint" },
  { "<leader>dl", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, desc = "Log Point" },
  { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
  { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run To Cursor" },
  { "<leader>ds", function() require("dap").continue() end, desc = "Start" },
  { "<leader>dS", function() require("dap").continue({ before = utils.get_args }) end, desc = "Run with Args" },

  -- Stepping
  { "<leader>db", function() require("dap").step_back() end, desc = "Step Back" },
  { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
  { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
  { "<leader>du", function() require("dap").step_out() end, desc = "Step Out" },

  -- Session control
  { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
  { "<leader>dd", function() require("dap").disconnect() end, desc = "Disconnect" },
  { "<leader>dq", function() require("dap").close() end, desc = "Quit" },
  { "<leader>dg", function() require("dap").session() end, desc = "Get Session" },

  -- REPL & UI
  { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
  { "<leader>dU", function() require("dapui").toggle({ reset = true }) end, desc = "Toggle UI" },

  -- Evaluation & Widgets
  { "<leader>dE", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" } },
  { "<leader>dK", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },

  -- Telescope integration
  { "<leader>df", function() require('telescope').extensions.dap.configurations() end, desc = "Configurations" },
})
