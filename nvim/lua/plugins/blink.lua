return {
    {
        "saghen/blink.cmp",
        version = "*",
        dependencies = {
            "L3MON4D3/LuaSnip",
        },
        opts = {
            keymap = {
                preset = "none",
                ["<C-n>"] = {
                    "show",
                    "show_documentation",
                    "hide_documentation",
                },
                ["<C-e>"] = { "hide", "fallback" },
                ["<CR>"] = { "accept", "fallback" },

                ["<C-f>"] = { "snippet_forward", "fallback" },
                ["<C-S-f>"] = { "snippet_backward", "fallback" },

                ["<S-Tab>"] = { "select_prev", "fallback" },
                ["<Tab>"] = { "select_next", "fallback" },

                ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                ["<C-d>"] = { "scroll_documentation_down", "fallback" },

                ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },
            cmdline = {
                enabled = false,
            },
            completion = {
                menu = {
                    auto_show = false,
                    draw = {
                        columns = {
                            { "kind_icon" },
                            { "label", "label_description", "source_name", gap = 1 },
                        },
                    },
                },
            },
            snippets = { preset = "luasnip" },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            fuzzy = { implementation = "prefer_rust" },
        },
        opts_extend = { "sources.default" },
    },
}
