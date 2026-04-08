-- grug-far.nvim: project-wide search and replace (more ergonomic than spectre)
-- <leader>rr → open on current word
-- <leader>rR → open (blank)
-- <leader>rw → open on visual selection
-- <leader>rs → open on current file only

return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  keys = {
    {
      "<leader>rr",
      function()
        require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
      end,
      desc = "Search/replace current word",
    },
    {
      "<leader>rR",
      function() require("grug-far").open() end,
      desc = "Search/replace (blank)",
    },
    {
      "<leader>rw",
      function() require("grug-far").with_visual_selection() end,
      mode = "v",
      desc = "Search/replace selection",
    },
    {
      "<leader>rs",
      function()
        require("grug-far").open({
          prefills = { paths = vim.fn.expand("%") },
        })
      end,
      desc = "Search/replace in current file",
    },
  },
  opts = {
    headerMaxWidth = 80,
  },
}
