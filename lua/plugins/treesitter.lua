return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        -- A list of parser names, or "all" (the four listed parsers should always be installed)
        ensure_installed = {
            "bash",
            "c",
            "clojure",
            "haskell",
            "help",
            "html",
            "java",
            "javascript",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "org",
            "python",
            "racket",
            "rust",
            "scala",
            "typescript",
            "vim",
            "yaml",
        },
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,
        highlight = {
            enable = true,
            disable = { "org" },
            additional_vim_regex_highlighting = { "org" },
            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            -- additional_vim_regex_highlighting = false,
        },
    },
}
