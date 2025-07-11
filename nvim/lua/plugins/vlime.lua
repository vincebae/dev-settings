local supported_filetypes = { "lisp" }
local vlime_filetypes = {
    "vlime_arglist",
    "vlime_input",
    "vlime_inspector",
    "vlime_mrepl",
    "vlime_notes",
    "vlime_preview",
    "vlime_repl",
    "vlime_server",
    "vlime_sldb",
    "vlime_threads",
    "vlime_trace",
    "vlime_xref",
}

vim.g.vlime_window_settings = {
    -- Open repl window vertical to the left by default.
    repl = {
        pos = "topleft",
        size = nil,
        vertical = true,
    },
}

return {
    "vlime/vlime",
    ft = supported_filetypes,
    lazy = false,
    dependencies = {
        "folke/which-key.nvim",
    },
    config = function()
        local function evaluate_input_text()
            local expr = vim.fn.input("Evaluate Expr: ")
            if expr and expr ~= "" then
                local su = require("utils.string_utils")
                local escaped = su.make_literal(expr)
                vim.cmd("call vlime#plugin#SendToREPL(" .. escaped .. ")")
            end
        end

        local function configure_keymap()
            local which_key = require("which-key")
            which_key.add({
                buffer = true,
                {
                    { "<localleader>c", group = "Vlime Connection" },
                    { "<localleader>cc", desc = "Connect to Server" },
                    { "<localleader>cs", desc = "Switch Connection" },
                    { "<localleader>cd", desc = "Disconnect" },
                    { "<localleader>cR", desc = "Rename Current Connection" },
                },
                {
                    { "<localleader>r", group = "Vlime Server" },
                    { "<localleader>rr", desc = "Run New Server" },
                    { "<localleader>rv", desc = "View Current Console Output" },
                    { "<localleader>rV", desc = "View Selected Console Output" },
                    { "<localleader>rs", desc = "Stop Current Server" },
                    { "<localleader>rS", desc = "Stop Selected Server" },
                    { "<localleader>rR", desc = "Rename Server" },
                    { "<localleader>rt", desc = "Restart Server" },
                    { "<localleader>rc", desc = "Clear REPL Buffer" },
                },
                {
                    { "<localleader>e", group = "Vlime Send to Evaluate" },
                    {
                        "<localleader>ee",
                        "<cmd>call vlime#plugin#SendToREPL(vlime#ui#CurExpr())<cr>",
                        desc = "Expression",
                    },
                    {
                        "<localleader>er",
                        "<cmd>call vlime#plugin#SendToREPL(vlime#ui#CurTopExpr())<cr>",
                        desc = "Top Level Expression",
                    },
                    {
                        "<localleader>ew",
                        "<cmd>call vlime#plugin#SendToREPL(vlime#ui#CurAtom())<cr>",
                        desc = "Atom",
                    },
                    {
                        "<localleader>ef",
                        '<cmd>call vlime#plugin#CompileFile(expand("%:p"))<cr>',
                        desc = "Compile File",
                    },
                    {
                        "<localleader>ei",
                        "<cmd>call vlime#plugin#SendToREPL()<cr>",
                        desc = "Snippet",
                    },
                    {
                        "<localleader>e:",
                        evaluate_input_text,
                        desc = "Input",
                    },
                    {
                        mode = "v",
                        {
                            "<localleader>E",
                            "<cmd>call vlime#plugin#SendToREPL(vlime#ui#CurSelection())<cr>",
                            desc = "Vlime Evaluate Current Selection",
                        },
                    },

                    -- Disable default keymaps
                    { "<localleader>ss", "<nop>", hidden = true },
                    { "<localleader>se", "<nop>", hidden = true },
                    { "<localleader>st", "<nop>", hidden = true },
                    { "<localleader>sa", "<nop>", hidden = true },
                    { "<localleader>si", "<nop>", hidden = true },
                    {
                        mode = "v",
                        { "<localleader>s", "<nop>", hidden = true },
                    },
                },
                {
                    { "<localleader>m", group = "Vlime Macros" },
                    { "<localleader>mm", desc = "Expand Macro" },
                    { "<localleader>m1", desc = "Expand Macro Once" },
                    { "<localleader>ma", desc = "Expand All Nested Macros" },
                },
                {
                    { "<localleader>o", group = "Vlime Compile" },
                    { "<localleader>oe", desc = "Compile Expression" },
                    { "<localleader>ot", desc = "Compile Top Level Expression" },
                    { "<localleader>of", desc = "Compile File" },
                    {
                        mode = "v",
                        { "<localleader>o", desc = "Compile Current Selection" },
                    },
                },
                {
                    { "<localleader>x", group = "Vlime Cross References" },
                    { "<localleader>xc", desc = "Show Callers" },
                    { "<localleader>xC", desc = "Show Callees" },
                    { "<localleader>xr", desc = "Show References" },
                    { "<localleader>xb", desc = "Show Bindings" },
                    { "<localleader>xs", desc = "Show Locations" },
                    { "<localleader>xe", desc = "Show Macro" },
                    { "<localleader>xm", desc = "Show Method" },
                    { "<localleader>xd", desc = "Show Definition" },
                    { "<localleader>xi", desc = "Select from List" },
                },
                {
                    { "<localleader>d", group = "Vlime Desciptions" },
                    { "<localleader>do", desc = "Describe Operator" },
                    { "<localleader>da", desc = "Describe Atom" },
                    { "<localleader>di", desc = "Describe Input Symbol" },
                    { "<localleader>ds", desc = "Apropos Search" },
                    { "<localleader>dr", desc = "Show Argument List" },
                    { "<localleader>dd", group = "Documenation" },
                    { "<localleader>ddo", desc = "Operator Documentation" },
                    { "<localleader>dda", desc = "Atom Documentation" },
                    { "<localleader>ddi", desc = "Input Symbol Documentation" },
                },
                {
                    { "<localleader>I", group = "Vlime Evaluate / Inspection" },
                    { "<localleader>Ii", desc = "Expression / Atom" },
                    { "<localleader>II", desc = "Expression / Atom" },
                    { "<localleader>Ie", desc = "Expression" },
                    { "<localleader>IE", desc = "Expression" },
                    { "<localleader>It", desc = "Top Level Expression" },
                    { "<localleader>IT", desc = "Top Level Expression" },
                    { "<localleader>Ia", desc = "Atom" },
                    { "<localleader>IA", desc = "Atom" },
                    { "<localleader>Is", desc = "Symbol" },
                    { "<localleader>IS", desc = "Symbol" },
                    { "<localleader>In", desc = "Snippet" },
                    { "<localleader>IN", desc = "Snippet" },
                    {
                        mode = "v",
                        { "<localleader>I", desc = "Vlime Evaluate Current Selection" },
                    },
                },
                {
                    { "<localleader>T", group = "Vlime Trace Dialog" },
                    { "<localleader>Td", desc = "Show Trace Dialog" },
                    { "<localleader>TD", desc = "Show Trace Dialog" },
                    { "<localleader>Ti", desc = "Trace Input Function" },
                    { "<localleader>TI", desc = "Trace Input Function" },
                    { "<localleader>Tt", desc = "Trace Current Function" },
                    { "<localleader>TT", desc = "Trace Current Function" },
                },
                {
                    { "<localleader>u", group = "Vlime Undefine" },
                    { "<localleader>uf", desc = "Undefine Function" },
                    { "<localleader>us", desc = "Undefine Symbol" },
                    { "<localleader>ui", desc = "Undefine Input Function / Symbol" },
                },
                {
                    { "<localleader>w", group = "Vlime Windows" },
                    { "<localleader>wp", desc = "Close Preview Windows" },
                    { "<localleader>wr", desc = "Close Arglist Windows" },
                    { "<localleader>wn", desc = "Close Compiler Windows" },
                    { "<localleader>wR", desc = "Close REPL Windows" },
                    { "<localleader>wA", desc = "Close All Vlime Windows" },
                    { "<localleader>wl", desc = "Close Selected Window" },
                },

                { "<localleader>a", desc = "Vlime Disassemble the Form" },
                { "<localleader>p", desc = "Vlime Specify Package" },
                { "<localleader>b", desc = "Vlime Set Breakpoint" },
                { "<localleader>t", desc = "Vlime List Threads" },
            })
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = supported_filetypes,
            callback = function()
                vim.schedule(configure_keymap)
            end,
        })

        -- Many keymappings are not working in vlime wndows,
        -- and somehow keymapping with "buffer = true" doesn't work for vlime_repl,
        -- so the configuration above doesn't work.
        -- For better experience, configure evaluation keymap for vlime types.
        -- Note that evaluate / compile file is not included.
        local function configure_vlime_window_keymap()
            require("which-key").add({
                { "<localleader>e", group = "Vlime Send to Evaluate" },
                {
                    "<localleader>ee",
                    "<cmd>call vlime#plugin#SendToREPL(vlime#ui#CurExpr())<cr>",
                    desc = "Expression",
                },
                {
                    "<localleader>er",
                    "<cmd>call vlime#plugin#SendToREPL(vlime#ui#CurTopExpr())<cr>",
                    desc = "Top Level Expression",
                },
                {
                    "<localleader>ew",
                    "<cmd>call vlime#plugin#SendToREPL(vlime#ui#CurAtom())<cr>",
                    desc = "Atom",
                },
                {
                    "<localleader>ei",
                    "<cmd>call vlime#plugin#SendToREPL()<cr>",
                    desc = "Snippet",
                },
                {
                    "<localleader>e:",
                    evaluate_input_text,
                    desc = "Input",
                },
                {
                    mode = "v",
                    {
                        "<localleader>E",
                        "<cmd>call vlime#plugin#SendToREPL(vlime#ui#CurSelection())<cr>",
                        desc = "Vlime Evaluate Current Selection",
                    },
                },
            })
        end
        vim.api.nvim_create_autocmd("FileType", {
            pattern = vlime_filetypes,
            callback = function()
                vim.schedule(configure_vlime_window_keymap)
            end,
        })
    end,
}
