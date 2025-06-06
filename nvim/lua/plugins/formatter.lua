return {
    {
        "stevearc/conform.nvim",
        keys = {
            {
                "<leader>F",
                function()
                    require("conform").format()
                end,
            },
        },
        opts = {
            formatters_by_ft = {
                clojure = {
                    "cljfmt",
                },
                javascript = {
                    "prettier",
                },
                json = {
                    "jq",
                },
                lua = {
                    "stylua",
                },
                python = {
                    "isort",
                    "black",
                },
                scala = {
                    "scalafmt",
                },
                typescript = {
                    "prettier",
                },
                xml = {
                    "xmlformatter",
                },
                yaml = {
                    "yq",
                },
            },
            formatters = {
                stylua = {
                    inherit = true,
                    args = {
                        "--search-parent-directories",
                        "--respect-ignores",
                        "--indent-type",
                        "Spaces",
                        "--stdin-filepath",
                        "$FILENAME",
                        "-",
                    },
                },
            },
            -- format_on_save = {
            --     timeout_ms = 5000,
            --     lsp_fallback = true,
            -- },
        },
    },
}
