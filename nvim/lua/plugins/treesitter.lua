return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        -- lazy = false,
        dependencies = {
            "nvim-treesitter/playground",
        },
        config = function()
            require("nvim-treesitter.config").setup({
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
            require("nvim-treesitter.config").setup({
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ap"] = "@parameter.outer",
                            ["ip"] = "@parameter.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                        -- select mode (default is charwise 'v')
                        selection_modes = {},
                        include_surrounding_whitespace = true,
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]]"] = { query = "@function.outer", desc = "Next function start" },
                            ["]p"] = { query = "@parameter.inner", desc = "Next parameter start" },
                        },
                        goto_next_end = {
                            ["]e"] = { query = "@function.outer", desc = "Next function end" },
                            ["]P"] = { query = "@parameter.inner", desc = "Next parameter end" },
                        },
                        goto_previous_start = {
                            ["[["] = { query = "@function.outer", desc = "Prev function start" },
                            ["[p"] = { query = "@parameter.inner", desc = "Prev parameter start" },
                        },
                        goto_previous_end = {
                            ["[e"] = { query = "@function.outer", desc = "Prev function end" },
                            ["[P"] = { query = "@parameter.inner", desc = "Prev parameter end" },
                        },
                        -- Below will go to either the start or the end, whichever is closer.
                        -- Use if you want more granular movements
                        -- Make it even more gradual by adding multiple queries and regex.
                        goto_next = {
                            ["]c"] = { query = "@class.outer", desc = "Next class" },
                        },
                        goto_previous = {
                            ["[c"] = { query = "@class.outer", desc = "Prev class" },
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>a"] = { query = "@parameter.inner", desc = "Swap parameter with next" }
                        },
                        swap_previous = {
                            ["<leader>A"] = { query = "@parameter.inner", desc = "Swap parameter with prev" }
                        },
                    },
                },
            })
        end,
    },
}
