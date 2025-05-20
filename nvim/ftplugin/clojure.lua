vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Confure auto repl
vim.cmd([[let g:conjure#client#clojure#nrepl#connection#auto_repl#cmd = "bb nrepl-server $port"]])

local doc_str = function()
    local expr = vim.fn.input("Symbol > ")
    vim.cmd("ConjureEval (clojure.repl/doc " .. expr .. ")")
end

-- Clojure specific which-key mapping
local which_key = require("which-key")
which_key.add({
    { "<localleader>ed", doc_str, desc = "Doc String" },
})

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
