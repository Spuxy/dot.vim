local M = {
  "CopilotC-Nvim/CopilotChat.nvim",
  cond = function()
    return vim.env.NO_COPILOT ~= "1"
  end,
  dependencies = {
    { "github/copilot.vim" },
    { "nvim-lua/plenary.nvim" },
  },
  keys = {
    -- c = { name = "Copilot", desc = "AI Code Assistant", icon = "🤖" },
    { "<leader>c", "Copilot", desc = "Copilot", icon = "🤖" },
    { "<leader>ct", "<cmd>CopilotChatToggle<cr>", desc = "Toggle" },
    { "<leader>co", "<cmd>CopilotChatOpen<cr>", desc = "Open" },
    { "<leader>cc", "<cmd>CopilotChatClose<cr>", desc = "Close" },
    { "<leader>cs", "<cmd>CopilotChatSave<cr>", desc = "Save Chat" },
    { "<leader>cl", "<cmd>CopilotChatLoad<cr>", desc = "Load Chat" },
    { "<leader>cp", "<cmd>CopilotChatPrompts<cr>", desc = "Prompts" },
    { "<leader>cm", "<cmd>CopilotChatModels<cr>", desc = "Models" },

    {
      "<leader>ce",
      "<cmd>CopilotChatExplain<cr>",
      desc = "Explain: Write detailed explanation of selected code as paragraphs",
    },
    {
      "<leader>cv",
      "<cmd>CopilotChatReview<cr>",
      desc = "Review: Comprehensive code review with line-specific issue reporting",
    },
    {
      "<leader>cf",
      "<cmd>CopilotChatFix<cr>",
      desc = "Fix: Identify problems and rewrite code with fixes and explanation",
    },
    {
      "<leader>co",
      "<cmd>CopilotChatOptimize<cr>",
      desc = "Optimize: Improve performance and readability with optimization strategy",
    },
    { "<leader>cd", "<cmd>CopilotChatDocs<cr>", desc = "Docs: Add documentation comments to selected code" },
    { "<leader>cy", "<cmd>CopilotChatTests<cr>", desc = "Tests: Generate tests for selected code" },
    {
      "<leader>cg",
      "<cmd>CopilotChatCommit<cr>",
      desc = "Commit: Generate commit message with commitizen convention from staged changes",
    },
    {
      "<leader>cf",
      "functions",
      desc = "predefined functions",
      icon = "🔧",
    },
    {
      "<leader>cfb",
      "bash",
      desc = "@copilot",
      icon = "🐚",
    },
  },
  opts = {
    show_help = "yes",
    window = {
      layout = "float",
      width = 80, -- Fixed width in columns
      height = 20, -- Fixed height in rows
      border = "rounded", -- 'single', 'double', 'rounded', 'solid'
      title = "🤖 AI Assistant",
      zindex = 100, -- Ensure window stays on top
    },
    model = "gpt-4.1", -- AI model to use
    temperature = 0.1, -- Lower = focused, higher = creative
    auto_insert_mode = true, -- Enter insert mode when opening
    headers = {
      user = "👤 You",
      assistant = "🤖 Copilot",
      tool = "🔧 Tool",
    },
    separator = "━━",
    auto_fold = true, -- Automatically folds non-assistant messages
  },
  cmd = { "CopilotChat", "CopilotChatOpen", "CopilotChatToggle" },
}

return M
