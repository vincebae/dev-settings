vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.colorcolumn = "80"

-- Confure auto repl
-- local repl_cmd = [["bb nrepl-server $port"]]
local repl_cmd = [["clj -Sdeps '{:deps {nrepl/nrepl {:mvn/version \"1.3.1\"}}}' -M -m nrepl.cmdline"]]
vim.cmd([[let g:conjure#client#clojure#nrepl#connection#auto_repl#cmd = ]] .. repl_cmd)

local function doc_str()
    local expr = vim.fn.input("Symbol > ")
    vim.cmd("ConjureEval (clojure.repl/doc " .. expr .. ")")
end

local pu = require("utils.path_utils")
local cu = require("utils.clj_utils")

local function eval_buf_and_command(command)
    local filename = pu.relative_path()
    local load_file_command = "(load-file \"" .. filename .. "\")"
    vim.cmd("ConjureEval (do " .. load_file_command .. " " .. command .. ")")
end

local function reload_namespace()
    local namespace = cu.get_namespace()
    local command = "(require'" .. namespace .. " :reload-all)"
    eval_buf_and_command(command)
end

local function into_namespace()
    local namespace = cu.get_namespace()
    local command = "(in-ns '" .. namespace .. ")"
    eval_buf_and_command(command)
end

local function test_namespace()
    local namespace = cu.get_namespace()
    local command = "(clojure.test/run-tests '" .. namespace .. ")"
    eval_buf_and_command(command)
end

-- Clojure specific which-key mapping
local which_key = require("which-key")
which_key.add({
    { "<localleader>ed", doc_str, desc = "Doc String" },
    { "<localleader>n", group = "Namespace" },
    {
        { "<localleader>nr", reload_namespace, desc = "Reload Namespace" },
        { "<localleader>ns", into_namespace, desc = "Into Namespace" },
        { "<localleader>nt", test_namespace, desc = "Test Namespace" },
    },
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
