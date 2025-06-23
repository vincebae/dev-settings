return {
    "julienvincent/nvim-paredit",
    config = function()
        local paredit = require("nvim-paredit")
        paredit.setup({
            use_default_keys = true,
            filetypes = {
                "clojure",
                "fennel",
                "scheme",
                "lisp",
                "janet",
            },
        })
    end,
}
