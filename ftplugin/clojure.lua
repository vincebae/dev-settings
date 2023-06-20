vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Confure auto repl
vim.cmd([[let g:conjure#client#clojure#nrepl#connection#auto_repl#enabled = v:true]])
vim.cmd([[let g:conjure#client#clojure#nrepl#connection#auto_repl#cmd = "bb nrepl-server $port"]])

-- Clojure specific which-key mapping
local which_key = require("which-key")
local opts = {
    mode = "n",  -- NORMAL mode
    prefix = "<localleader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local v_opts = {
    mode = "v",  -- VISUAL mode
    prefix = "<localleader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    c = {
        name = "Conjure Connection",
        c = { "<cmd>ConjureConnect<cr>", "Connect" },
        p = {
            function()
                local port = vim.fn.input("Port > ", "1667")
                vim.cmd("ConjureConnect " .. port)
            end,
            "Connect to port",
        },
        s = {
            function()
                local key = vim.fn.input("Key > ")
                vim.cmd("ConjureClientState " .. key)
            end,
            "Client state",
        },
    },

    l = {
        name = "Log buffer",
        s = { "Split down" },
        v = { "Split right" },
        t = { "New tab" },
        e = { "Current window" },
        q = { "Close aall in tab" },
        r = { "Soft reset" },
        R = { "Hard reset" },
        l = { "Latest result" },
    },

    E = "Evaluate motion",

    e = {
        name = "Evaluate",
        e = { "Innermost" },
        r = { "Outermost" },
        w = { "Word" },
        f = { "File" },
        b = { "Buffer" },
        ["!"] = { "Eval and replace" },
        c = {
            name = "Evaluate and comment",
            e = { "Innermost" },
            r = { "Outermost" },
            w = { "Word" },
        },
    },
}

local v_mappings = {
    E = "Evaluate",
}

which_key.register(mappings, opts)
which_key.register(v_mappings, v_opts)
