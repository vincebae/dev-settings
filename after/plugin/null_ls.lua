local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.completion.spell,
        null_ls.builtins.completion.tags,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.google_java_format,
        null_ls.builtins.formatting.shfmt,    -- shell script formatting
        null_ls.builtins.formatting.prettier, -- markdown formatting
    },
})
