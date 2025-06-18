vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets("clojure", {
    s("bb", {
        t({
            "#!/usr/bin/env bb",
            "",
        }),
    }),
    s("shell", {
        t({
            "(require '[babashka.process :refer [sh]])",
            "",
        }),
    }),
}, { key = "clojure" })
