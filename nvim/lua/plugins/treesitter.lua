return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        -- lazy = false,
        dependencies = {
            "nvim-treesitter/playground",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                -- A list of parser names, or "all" (the four listed parsers should always be installed)
                ensure_installed = {
                    "bash",
                    "c",
                    "clojure",
                    "commonlisp",
                    "fennel",
                    "haskell",
                    "html",
                    "java",
                    "javascript",
                    "json",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "proto",
                    "python",
                    "query",
                    "racket",
                    "rust",
                    "scala",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "yaml",
                },
                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,
                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = false,
                },
                playground = {
                    enabled = true,
                    disable = {},
                    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = false, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = "o",
                        toggle_hl_groups = "i",
                        toggle_injected_languages = "t",
                        toggle_anonymous_nodes = "a",
                        toggle_language_display = "I",
                        focus_language = "f",
                        unfocus_language = "F",
                        update = "R",
                        goto_node = "<cr>",
                        show_help = "?",
                    },
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        -- lazy = false,
        config = function()
            require("nvim-treesitter.configs").setup({
                textobjects = {
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]f"] = { query = "@function.outer", desc = "Next function start"},
                            ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope start" },
                        },
                        goto_next_end = {
                            ["]F"] = { query = "@function.outer", desc= "Next function end"},
                            ["]S"] = { query = "@local.scope", query_group = "locals", desc = "Next scope start" },
                        },
                        goto_previous_start = {
                            ["[f"] = { query = "@function.outer", desc = "Prev function start" },
                            ["[s"] = { query = "@local.scope", query_group = "locals", desc = "Prev scope start" },
                        },
                        goto_previous_end = {
                            ["[F"] = { query = "@function.outer", desc = "Prev function end" },
                            ["[S"] = { query = "@local.scope", query_group = "locals", desc = "Prev scope start" },
                        },
                        -- Below will go to either the start or the end, whichever is closer.
                        -- Use if you want more granular movements
                        -- Make it even more gradual by adding multiple queries and regex.
                        goto_next = {
                        },
                        goto_previous = {
                        },
                    },
                },
            })
        end,
    },
}
