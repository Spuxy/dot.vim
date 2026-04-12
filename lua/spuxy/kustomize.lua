-- kustomize.nvim — Kustomize build, validate, and resource navigation
--
-- Requires in $PATH: kustomize, kubeconform (validation), kubent (deprecation checks)

local M = {
  "Allaman/kustomize.nvim",
  ft = "yaml",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    kinds = {
      show_filepath = true,
      show_line = true,
    },
  },
  keys = {
    { "<leader>kb", "<cmd>KustomizeBuild<cr>",          desc = "Kustomize build" },
    { "<leader>kk", "<cmd>KustomizeListKinds<cr>",      desc = "List kinds" },
    { "<leader>kl", "<cmd>KustomizeListResources<cr>",  desc = "List resources" },
    { "<leader>kp", "<cmd>KustomizePrintResources<cr>", desc = "Print resources" },
    { "<leader>kv", "<cmd>KustomizeValidate<cr>",       desc = "Validate" },
    { "<leader>kd", "<cmd>KustomizeDeprecations<cr>",   desc = "Check deprecations" },
  },
}

return M
