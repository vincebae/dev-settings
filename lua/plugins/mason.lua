return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
        "williamboman/mason.nvim",
    },
    opts = {
        ensure_installed = {
            "bash-language-server",
            "google-java-format",
            "haskell-language-server",
            "lua-language-server",
            "stylua",
            "typescript-language-server",
            "vim-language-server",
        },
        run_on_start = true,
        start_delay = 1000,
    },
}
