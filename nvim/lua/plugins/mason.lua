return {
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        build = ":MasonToolsUpdate",
        dependencies = {
            {
                "mason-org/mason.nvim",
                opts = {},
            },
            {
                "mason-org/mason-lspconfig.nvim",
                opts = {
                    automatic_enable = false,
                },
            },
        },
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "autopep8",
                    "bash-language-server",
                    "black",
                    "clj-kondo",
                    "clojure-lsp",
                    "eslint_d",
                    "flake8",
                    "google-java-format",
                    "isort",
                    "jdtls",
                    "jedi-language-server",
                    "jq",
                    "local-lua-debugger-vscode",
                    "lua-language-server",
                    "prettier",
                    "stylua",
                    "typescript-language-server",
                    "xmlformatter",
                    "yq",
                },

                auto_update = false,
                run_on_start = true,
                start_delay = 3000, -- 3 second delay
                debounce_hours = 5, -- at least 5 hours between attempts to install/update
                integrations = {
                    ["mason-lspconfig"] = true,
                },
            })
        end,
    },
}
