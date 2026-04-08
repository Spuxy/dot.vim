-- vim-fugitive: the premier git plugin for Vim
-- GV: git commit browser (requires gv.vim)
--
-- Useful commands:
--   :Git           → fugitive status (press ? for help)
--   :Git log       → log
--   :Git blame     → inline blame
--   :GV            → commit browser for whole repo
--   :GV!           → commit browser for current file
--   :GV?           → list commits that changed current file in loclist
--   :Gcn           → create + checkout a new branch

return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "GV", "Gcn" },
    keys = {
      { "<leader>gg", "<cmd>Git<cr>",          desc = "Git status (fugitive)" },
      { "<leader>gG", "<cmd>Git log<cr>",      desc = "Git log" },
      { "<leader>gv", "<cmd>GV<cr>",           desc = "Git commit browser" },
      { "<leader>gV", "<cmd>GV!<cr>",          desc = "Git commits for this file" },
      { "<leader>gb", "<cmd>Git blame<cr>",    desc = "Git blame" },
    },
    config = function()
      -- Fold git filetype windows with za
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "git",
        callback = function()
          vim.opt_local.foldenable = true
          vim.opt_local.foldmethod = "syntax"
        end,
      })
      -- :Gcn → create and checkout a new branch
      vim.api.nvim_create_user_command("Gcn", function(opts)
        vim.cmd("Git checkout -b " .. opts.args)
      end, { nargs = 1, desc = "Git create and checkout new branch" })
    end,
  },
  {
    "junegunn/gv.vim",
    cmd = "GV",
    dependencies = { "tpope/vim-fugitive" },
  },
}
