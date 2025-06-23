return {
    {
        "Wansmer/treesj",
        keys = { "gS" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            local treesj = require("treesj")
            treesj.setup({
                use_default_keymaps = true,
                max_join_length = 1000,
            })
            vim.keymap.set("n", "gS", treesj.toggle, {
                desc = "Toggle splitjoin",
            })
        end,
    },
}
