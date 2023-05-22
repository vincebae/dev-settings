return {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.code_actions.shellcheck,
                null_ls.builtins.code_actions.refactoring,
                null_ls.builtins.code_actions.cspell,
                null_ls.builtins.completion.spell,
                null_ls.builtins.completion.tags,
                null_ls.builtins.diagnostics.eslint,
                null_ls.builtins.diagnostics.clj_kondo,
                null_ls.builtins.diagnostics.flake8.with({
                    extra_args = { "--ignore", "e501", "--select", "e126" }
                }),
                null_ls.builtins.diagnostics.pylint.with({
                    extra_args = { "--disable", "c0114,c0115,c0116,c0301,w1203,w0703" },
                }),
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.cljstyle,
                null_ls.builtins.formatting.google_java_format,
                null_ls.builtins.formatting.prettier, -- markdown formatting
                null_ls.builtins.formatting.raco_fmt,
                null_ls.builtins.formatting.rustfmt,
                null_ls.builtins.formatting.shfmt,    -- shell script formatting
                null_ls.builtins.formatting.stylish_haskell,
                null_ls.builtins.formatting.stylua,
            },
        })
    end,
}
