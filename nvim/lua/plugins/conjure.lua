-- lisp is handled by vlime, so no lisp here.
local filetypes = {
    "clojure",
    "fennel",
    "lua",
    "python",
}
return {
    {
        "Olical/conjure",
        ft = filetypes,
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                dependencies = {
                    "nvim-treesitter",
                },
                config = function() end,
            },
            {
                "folke/which-key.nvim",
            },
        },
        config = function()
            vim.g["conjure#extract#tree_sitter#enabled"] = true

            -- Evaluate text from the user input
            local eval_input_text = function()
                local expr = vim.fn.input("Evaluate Expr: ")
                if expr and expr ~= "" then
                    vim.cmd("ConjureEval " .. expr)
                end
            end

            local function configure_keymap()
                vim.keymap.set("n", "<localleader>e:", eval_input_text, { buffer = true, desc = "Evaluate Input Text" })

                local which_key = require("which-key")
                which_key.add({
                    buffer = true,
                    { "<localleader>c", group = "Conjure Connection" },
                    { "<localleader>e", group = "Conjure Evaluate" },
                    { "<localleader>ec", group = "Conjure Eval and Comment" },
                    { "<localleader>g", group = "Conjure Goto" },
                    { "<localleader>l", group = "Conjure Log buffer" },
                    { "<localleader>r", group = "Conjure Refresh" },
                    { "<localleader>s", group = "Conjure REPL Session" },
                    { "<localleader>t", group = "Conjure Testing" },
                    { "<localleader>v", group = "Conjure View" },
                })
            end

            vim.api.nvim_create_autocmd("FileType", {
                pattern = filetypes,
                callback = function()
                    vim.schedule(configure_keymap)
                end,
            })
        end,
    },
}
