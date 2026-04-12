-- mini.align: align text interactively
-- ga  → start alignment (interactive)
-- gA  → start alignment with preview

return {
  "nvim-mini/mini.align",
  keys = {
    { "ga", mode = { "n", "v" }, desc = "Align (interactive)" },
    { "gA", mode = { "n", "v" }, desc = "Align with preview" },
  },
  opts = {},
}
