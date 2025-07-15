return {
    -- Usage: The three "core" operations of add/delete/change can be done with the keymaps
    -- 1. ys{motion}{char}
    -- 2. ds{char}
    -- 3. cs{target}{replacement}
    -- For the following examples, * will denote the cursor position:
    -- -----------------------------------------------------------------------------
    --  Old text                    Command         New text
    -- -----------------------------------------------------------------------------
    --  surr*ound_words             ysiw)           (surround_words)
    --  *make strings               ys$"            "make strings"
    --  [delete ar*ound me!]        ds]             delete around me!
    --  remove <b>HTML t*ags</b>    dst             remove HTML tags
    --  'change quot*es'            cs'"            "change quotes"
    --  <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
    --  delete(functi*on calls)     dsf             function calls
    {
        "kylechui/nvim-surround",
        version = "^3.0.0",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
            
            -- simplied keymaps for structural edit.
            local wraps = {
                ["("] = "()",
                ["["] = "[]",
                ["{"] = "{}",
            }
            local targets = {
                ["("] = "()",
                ["["] = "[]",
                ["{"] = "{}",
                e = "sexp element",
                f = "sexp form",
                F = "sexp top level form",
                w = "word",
                W = "WORD",
            }
            -- define keymaps based on the combination of wraps and targets, for example,
            -- `<leader>([` -> `ysa[(`
            -- `<leader>{w` -> `ysaw{`
            local which_key = require("which-key")
            for wk, wv in pairs(wraps) do
                for tk, tv in pairs(targets) do
                    local input = "<leader>" .. wk .. tk
                    local output = "ysa" .. tk .. wk
                    local description = "Wrap " .. tv .. " with " .. wv
                    vim.keymap.set("n", input, output, {
                        remap = true,
                        desc = description,
                    })
                end
                which_key.add({ "<leader>" .. wk, group = "Wrap with " .. wv })
            end
        end,
    },
}
