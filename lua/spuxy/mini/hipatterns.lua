-- mini.hipatterns: highlight patterns in text
-- Highlights hex color codes inline (e.g. #ff6600 shows with its actual color)

return {
  "nvim-mini/mini.hipatterns",
  event = { "BufReadPre", "BufNewFile" },
  opts = function()
    local hipatterns = require("mini.hipatterns")
    return {
      highlighters = {
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    }
  end,
}
