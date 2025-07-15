-- lisp is handled by vlime, so no lisp here.
local filetypes = {
    "clojure",
    "fennel",
    "lua",
    "python",
    "scheme",
}

vim.g["conjure#extract#tree_sitter#enabled"] = true

-- Clojure specific configuration.
local clj = require("utils.clj_utils")
vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = true
vim.g["conjure#client#clojure#nrepl#connection#auto_repl#cmd"] = clj.nrepl_server_command()

-- Scheme specific configuration. Use chicken scheme
vim.g["conjure#client#scheme#stdio#command"] = "csi -:c"
vim.g["conjure#client#scheme#stdio#prompt_pattern"] = "\n-#;%d-> "
vim.g["conjure#client#scheme#stdio#value_prefix_pattern"] = false

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
            -- Evaluate text from the user input
            local eval_input_text = function()
                local expr = vim.fn.input("Evaluate Expr: ")
                if expr and expr ~= "" then
                    vim.cmd("ConjureEval " .. expr)
                end
            end

            local function configure_keymap()
                -- Duplicate key mappings to use leader for easier access of evaluation.
                local keys = {
                    ee = "Evaluate current form",
                    er = "Evaluate root form",
                    ew = "Evaluate word",
                    eb = "Evaluate buffer",
                    ef = "Evaluate file",
                    E = "Evaluate motion",
                    le = "Open log in new buffer",
                    lg = "Toggle log buffer",
                    ll = "Jump to latest part of log",
                    lq = "Close all visible log windows",
                    lr = "Soft reset log",
                    lR = "Hard reset log",
                    ls = "Open log in new horizontal split window",
                    lt = "Open log in new tab",
                    lv = "Open log in new vertical split window",
                }

                for k, v in pairs(keys) do
                    local new_key = "<leader>" .. k
                    local target_key = "<localleader>" .. k
                    vim.keymap.set("n", new_key, target_key, {
                        buffer = true,
                        remap = true,
                        desc = v,
                    })
                end

                -- Some more key bindings
                vim.keymap.set("v", "<leader>E", "<localleader>E", {
                    buffer = true,
                    remap = true,
                    desc = "Evaluate visual select",
                })
                vim.keymap.set("n", "<leader>e:", eval_input_text, {
                    buffer = true,
                    desc = "Evaluate Input Text",
                })
                vim.keymap.set("n", "<localleader>e:", eval_input_text, {
                    buffer = true,
                    desc = "Evaluate Input Text",
                })

                local which_key = require("which-key")
                which_key.add({
                    buffer = true,
                    { "<leader>e", group = "Conjure Evaluate" },
                    { "<leader>l", group = "Conjure Log buffer" },

                    { "<localleader>c", group = "Conjure Connection" },
                    { "<localleader>e", group = "Conjure Evaluate" },
                    { "<localleader>ec", group = "Conjure Eval and Comment" },
                    { "<localleader>g", group = "Conjure Goto" },
                    { "<localleader>l", group = "Conjure Log buffer" },
                    { "<localleader>r", group = "Conjure Refresh" },
                    { "<localleader>s", group = "Conjure REPL Session" },
                    { "<localleader>t", group = "Conjure Testing" },
                    { "<localleader>v", group = "Conjure View" },
                    { "<localleader>x", group = "Conjure Macro" },
                })
            end

            -- FileType event doesn't work for log buffer, so use BufEnter instead.
            vim.api.nvim_create_autocmd("BufEnter", {
                callback = function()
                    local filetype = vim.bo.filetype
                    for _, ft in ipairs(filetypes) do
                        if ft == filetype then
                            vim.schedule(configure_keymap)
                            break
                        end
                    end
                end,
            })
        end,
    },
}
