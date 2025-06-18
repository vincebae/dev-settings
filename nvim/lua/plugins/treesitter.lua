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
                    "fennel",
                    "haskell",
                    "html",
                    "java",
                    "javascript",
                    "json",
                    "lisp",
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
        "stevearc/aerial.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            close_on_select = true,
            layout = {
                min_width = 20,
            },
            -- optionally use on_attach to set keymaps when aerial has attached to a buffer
            on_attach = function(bufnr)
                -- Jump forwards/backwards
                vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Aerial Prev" })
                vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Aerial Next" })
            end,
        },
        keys = {
            { "<leader>a", "<cmd>AerialToggle<CR>", desc = "Toggle Aerial" },
        },
    },
}
