require("lspconfig").clangd.setup({
  settings = {
    clangd = {
      init_options = {
        fallbackFlags = { '--std=c23' }
      },
    },
  },
})
