local M = {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim", branch = "master" },
  },
  build = "make tiktoken",
  opts = {
    window = {
      layout = 'float',
      width = 80,       -- Fixed width in columns
      height = 20,      -- Fixed height in rows
      border = 'rounded', -- 'single', 'double', 'rounded', 'solid'
      title = '🤖 AI Assistant',
      zindex = 100,     -- Ensure window stays on top
    },
    model = 'gpt-4.1',           -- AI model to use
    temperature = 0.1,           -- Lower = focused, higher = creative
    auto_insert_mode = true,     -- Enter insert mode when opening
    headers = {
      user = '👤 You',
      assistant = '🤖 Copilot',
      tool = '🔧 Tool',
    },

    separator = '━━',
    auto_fold = true, -- Automatically folds non-assistant messages
  },
}

return M
