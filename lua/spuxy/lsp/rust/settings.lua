return {
  cargo = {
    allFeatures = true,
    loadOutDirsFromCheck = true,
  },
  procMacro = {
    enable = true,
  },
  checkOnSave = {
    command = "clippy",
  },
  diagnostics = {
    enable = true,
    experimental = {
      enable = true,
    },
  },
}
