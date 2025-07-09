return {
    {
        "Wansmer/treesj",
        keys = {
            {
                "gS",
                function()
                    require("treesj").toggle()
                end,
                desc = "Toggle splitjoin",
            },
        },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            use_default_keymaps = false,
            max_join_length = 1000,
        },
    },
}
