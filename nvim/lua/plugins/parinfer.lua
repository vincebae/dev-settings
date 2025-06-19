return {
    {
        "gpanders/nvim-parinfer",
        ft = {
            "clojure",
            "fennel",
            "lisp",
        },
        config = function()
            vim.g["parinfer_mode"] = "paren"
        end,
    },
}
