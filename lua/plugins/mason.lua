return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
        "williamboman/mason.nvim",
    },
    opts = {
        ensure_installed = {
            "bash-language-server",
            "black",
            "eslint_d",
            "eslint-lsp",
            "flake8",
            "google-java-format",
            "haskell-language-server",
            "jdtls",
            "lua-language-server",
            "pyright",
            "rust-analyzer",
            "rustfmt",
            "stylua",
            "typescript-language-server",
            "vim-language-server",
        },
        run_on_start = true,
        start_delay = 1000,
    },
}
