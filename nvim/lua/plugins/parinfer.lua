return {
    {
        "eraserhd/parinfer-rust",
        ft = {
            "clojure",
        },
        build = "cargo build --release",
        config = function()
            vim.g["parinfer_mode"] = "paren"
        end,
    },
    -- {
    --     "gpanders/nvim-parinfer",
    --     ft = {
    --         "clojure",
    --     },
    -- },
}
