local map = vim.keymap.set
local utils = require("spuxy.core.functions")

-- DAP (Debug Adapter Protocol) keymaps
-- Breakpoints & Control
map("n", "<leader>dt", function() require("dap").toggle_breakpoint() end,                                    { desc = "Toggle Breakpoint" })
map("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Conditional Breakpoint" })
map("n", "<leader>dl", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point: ")) end,  { desc = "Log Point" })
map("n", "<leader>dc", function() require("dap").continue() end,                                             { desc = "Continue" })
map("n", "<leader>dC", function() require("dap").run_to_cursor() end,                                        { desc = "Run To Cursor" })
map("n", "<leader>ds", function() require("dap").continue() end,                                             { desc = "Start" })
map("n", "<leader>dS", function() require("dap").continue({ before = utils.get_args }) end,                  { desc = "Run with Args" })

-- Stepping
map("n", "<leader>db", function() require("dap").step_back() end,  { desc = "Step Back" })
map("n", "<leader>di", function() require("dap").step_into() end,  { desc = "Step Into" })
map("n", "<leader>do", function() require("dap").step_over() end,  { desc = "Step Over" })
map("n", "<leader>du", function() require("dap").step_out() end,   { desc = "Step Out" })

-- Session control
map("n", "<leader>dp", function() require("dap").pause() end,      { desc = "Pause" })
map("n", "<leader>dd", function() require("dap").disconnect() end, { desc = "Disconnect" })
map("n", "<leader>dq", function() require("dap").close() end,      { desc = "Quit" })
map("n", "<leader>dg", function() require("dap").session() end,    { desc = "Get Session" })

-- REPL & UI
map("n", "<leader>dr", function() require("dap").repl.toggle() end,              { desc = "Toggle REPL" })
map("n", "<leader>dU", function() require("dapui").toggle({ reset = true }) end, { desc = "Toggle UI" })

-- Evaluation & Widgets
map({ "n", "v" }, "<leader>dE", function() require("dapui").eval() end,          { desc = "Eval" })
map("n",          "<leader>dK", function() require("dap.ui.widgets").hover() end, { desc = "Widgets" })

-- Telescope integration
map("n", "<leader>df", function() require("telescope").extensions.dap.configurations() end, { desc = "Configurations" })
