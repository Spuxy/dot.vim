require("lspconfig").yamlls.setup({
    settings = {
        yaml = {
            -- validate = { enable = true },
            schemaStore = {
                enable = false,
                url = "",
            },
            schemas = require("schemastore").yaml.schemas()
        },
    },
})
