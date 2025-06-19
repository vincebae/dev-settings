return {
    "folke/which-key.nvim",
    config = function()
        local which_key = require("which-key")
        local setup = {
            preset = "helix",
            triggers = {
                { "<leader>", mode = { "n", "v" } },
                { "<localleader>", mode = { "n", "v" } },
                { "=", mode = { "n" } },
                { "[", mode = { "n" } },
                { "]", mode = { "n" } },
                { "<", mode = { "n" } },
                { ">", mode = { "n" } },
                { "c", mode = { "n" } },
                { "d", mode = { "n" } },
                { "g", mode = { "n" } },
                { "y", mode = { "n" } },
                { "z", mode = { "n", "v" } },
                { "<C-t>", mode = { "n", "v" } },
                { "<C-w>", mode = { "n" } },
            },
        }
        which_key.setup(setup)

        which_key.add({
            { "<C-t>", group = "Terminal" },
            { "<leader>b", group = "Buffer" },
            { "<leader>d", group = "DAP" },
            {
                mode = { "n", "v" },
                { "<leader>g", group = "Git" },
            },
            { "<leader>p", group = "Paste" },
            { "<leader>P", group = "Plugins" },
            { "<leader>s", group = "Snacks" },
            { "<localleader><localleader>", group = "Slime" },
        })
    end,
}
