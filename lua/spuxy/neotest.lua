local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    -- general tests
    "vim-test/vim-test",
    "nvim-neotest/neotest-vim-test",
    -- language specific tests
    "nvim-neotest/neotest-python",
    "rouge8/neotest-rust",
    "rcasia/neotest-bash",
    "fredrikaverpil/neotest-golang",
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter"
  },
}

function M.config()
  local map = vim.keymap.set
  map("n", "<leader>tt", "<cmd>lua require'neotest'.run.run()<cr>",                     { desc = "Test Nearest" })
  map("n", "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", { desc = "Test File" })
  map("n", "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", { desc = "Debug Test" })
  map("n", "<leader>ts", "<cmd>lua require('neotest').run.stop()<cr>",                  { desc = "Test Stop" })
  map("n", "<leader>ta", "<cmd>lua require('neotest').run.attach()<cr>",                { desc = "Attach Test" })

  ---@diagnostic disable: missing-fields
  ---require "neotest-zig",
  require("neotest").setup {
    output = {
      enabled = true,
      open_on_run = "short"
    },
    output_panel = {
      enabled = true,
      open = "botright split | resize 15"
    },
    adapters = {
      require "neotest-python" {
        dap = { justMyCode = false },
      },
      require "neotest-vim-test" {
        ignore_file_types = { "python", "vim", "lua", "javascript", "typescript" },
      },
      require("neotest-bash"),
      require("neotest-rust"),
      require("neotest-golang"),
    },
  }
end

return M
