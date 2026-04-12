-- mini.trailspace: highlight trailing whitespace and strip it on save

return {
  "nvim-mini/mini.trailspace",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("mini.trailspace").setup()
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        -- skip special buffers
        if vim.bo.buftype ~= "" then return end
        MiniTrailspace.trim()
        MiniTrailspace.trim_last_lines()
      end,
      desc = "Strip trailing whitespace and blank lines on save",
    })
  end,
}
