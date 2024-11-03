require("which-key").register({
    l = {
        F = { "<cmd>ToggleAutoformat<cr>", "Toggle Format on Save" },
    },
}, { prefix = "<leader>" })