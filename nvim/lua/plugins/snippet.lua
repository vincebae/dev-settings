return {
    {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        build = "make install_jsregexp",
        opts = {},
        config = function()
            require("luasnip.loaders.from_vscode").load({
                exclude = { "javascript" },
            })
        end,
    },
}
