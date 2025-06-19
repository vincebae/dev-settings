local filetypes = {
    "clojure",
    "scheme",
    "lisp",
    "timl",
    "fennel",
}
local filetypes_string = table.concat(filetypes, ",")
vim.cmd("let g:sexp_filetypes = '" .. filetypes_string .. "'")
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
        "tpope/vim-repeat",
        lazy = false,
        config = function() end,
    },
    {
        "tpope/vim-surround",
        lazy = false,
        config = function() end,
    },
    {
        "guns/vim-sexp",
        lazy = false,
        config = function() end,
    },
    {
        "tpope/vim-sexp-mappings-for-regular-people",
        lazy = false,
        config = function()
            local function configure_which_key()
                vim.keymap.set(
                    { "n", "v" },
                    "<localleader>k",
                    "<Plug>(sexp_raise_list)",
                    { noremap = false, buffer = true }
                )
                vim.keymap.set(
                    { "n", "v" },
                    "<localleader>K",
                    "<Plug>(sexp_raise_element)",
                    { noremap = false, buffer = true }
                )
                vim.keymap.set(
                    { "n", "v" },
                    "<localleader>((",
                    "<Plug>(sexp_round_head_wrap_list)",
                    { noremap = false, buffer = true }
                )
                vim.keymap.set(
                    { "n", "v" },
                    "<localleader>))",
                    "<Plug>(sexp_round_tail_wrap_list)",
                    { noremap = false, buffer = true }
                )
                vim.keymap.set(
                    { "n", "v" },
                    "<localleader>[[",
                    "<Plug>(sexp_square_head_wrap_list)",
                    { noremap = false, buffer = true }
                )
                vim.keymap.set(
                    { "n", "v" },
                    "<localleader>]]",
                    "<Plug>(sexp_square_tail_wrap_list)",
                    { noremap = false, buffer = true }
                )
                vim.keymap.set(
                    { "n", "v" },
                    "<localleader>{{",
                    "<Plug>(sexp_curly_head_wrap_list)",
                    { noremap = false, buffer = true }
                )
                vim.keymap.set(
                    { "n", "v" },
                    "<localleader>}}",
                    "<Plug>(sexp_curly_tail_wrap_list)",
                    { noremap = false, buffer = true }
                )
                vim.keymap.set(
                    { "n", "v" },
                    "<localleader>(e",
                    "<Plug>(sexp_round_head_wrap_element)",
                    { noremap = false, buffer = true }
                )
                vim.keymap.set(
                    { "n", "v" },
                    "<localleader>)e",
                    "<Plug>(sexp_round_tail_wrap_element)",
                    { noremap = false, buffer = true }
                )
                vim.keymap.set(
                    { "n", "v" },
                    "<localleader>[e",
                    "<Plug>(sexp_square_head_wrap_element)",
                    { noremap = false, buffer = true }
                )
                vim.keymap.set(
                    { "n", "v" },
                    "<localleader>]e",
                    "<Plug>(sexp_square_tail_wrap_element)",
                    { noremap = false, buffer = true }
                )

                vim.keymap.set(
                    { "n", "v" },
                    "<localleader>{e",
                    "<Plug>(sexp_curly_head_wrap_element)",
                    { noremap = false, buffer = true }
                )
                vim.keymap.set(
                    { "n", "v" },
                    "<localleader>}e",
                    "<Plug>(sexp_curly_tail_wrap_element)",
                    { noremap = false, buffer = true }
                )

                local which_key = require("which-key")
                which_key.add({
                    buffer = true,
                    { "dsf", desc = "Delete surroundings of form" },
                    { "cse", group = "Surround Element in" },
                    {
                        { "cseb", desc = "Parentheses" },
                        { "cse(", desc = "Parentheses" },
                        { "cse)", desc = "Parentheses" },
                        { "cse[", desc = "Brackets" },
                        { "cse]", desc = "Brackets" },
                        { "cse{", desc = "Curly Braces" },
                        { "cse}", desc = "Curly Braces" },
                    },
                    {
                        { "[e", desc = "Select Prev Top Element" },
                        { "]e", desc = "Select Next Top Element" },
                        { "[[", desc = "Move to Prev Top Element" },
                        { "]]", desc = "Move to Next Top Element" },
                    },
                    { "<", group = "Sexp Form Manipulation" },
                    {
                        { "<e", desc = "Swap Element Backward" },
                        { "<f", desc = "Swap Form Backward" },
                        { "<I", desc = "Insert at Form Head" },
                        { "<(", desc = "Capture Prev Element" },
                        { "<)", desc = "Emit Tail Element" },
                    },

                    { ">", group = "Sexp Form Manipulation" },
                    {
                        { ">e", desc = "Swap Element Forward" },
                        { ">f", desc = "Swap Form Forward" },
                        { ">I", desc = "Insert at Form Tail" },
                        { ">(", desc = "Emit Head Element" },
                        { ">)", desc = "Capture Next Element" },
                    },
                    {
                        { "<localleader>@", desc = "Sexp Splice Form" },
                        { "<localleader>?", desc = "Sexp Convolute" },
                        { "<localleader>h", desc = "Insert at Head of Form" },
                        { "<localleader>l", desc = "Insert at Tail of Form" },
                    },
                    {
                        mode = { "n", "v" },
                        { "<localleader>k", desc = "Sexp Raise Form" },
                        { "<localleader>K", desc = "Sexp Raise Element" },
                        { "<localleader>(", group = "Head Wrap ()" },
                        { "<localleader>((", desc = "Head Wrap Form ()" },
                        { "<localleader>(e", desc = "Head Wrap Element ()" },
                        { "<localleader>)", group = "Tail Wrap ()" },
                        { "<localleader>))", desc = "Tail Wrap Form ()" },
                        { "<localleader>)e", desc = "Tail Wrap Element ()" },
                        { "<localleader>[", group = "Head Wrap []" },
                        { "<localleader>[[", desc = "Head Wrap Form []" },
                        { "<localleader>[e", desc = "Head Wrap Element []" },
                        { "<localleader>]", group = "Tail Wrap []" },
                        { "<localleader>]]", desc = "Tail Wrap Form []" },
                        { "<localleader>]e", desc = "Tail Wrap Element []" },
                        { "<localleader>{", group = "Head Wrap {}" },
                        { "<localleader>{{", desc = "Head Wrap Form {}" },
                        { "<localleader>{e", desc = "Head Wrap Element {}" },
                        { "<localleader>}", group = "Tail Wrap {}" },
                        { "<localleader>}}", desc = "Tail Wrap Form {}" },
                        { "<localleader>}e", desc = "Tail Wrap Element {}" },
                    },

                    -- Disable some keymaps
                    {
                        mode = { "n", "v" },
                        { "<localleader>i", "<nop>", hidden = true },
                        { "<localleader>I", "<nop>", hidden = true },
                        { "<localleader>o", "<nop>", hidden = true },
                        { "<localleader>O", "<nop>", hidden = true },
                        { "<localleader>w", "<nop>", hidden = true },
                        { "<localleader>W", "<nop>", hidden = true },
                        { "<localleader>e[", "<nop>", hidden = true },
                        { "<localleader>e]", "<nop>", hidden = true },
                        { "<localleader>e{", "<nop>", hidden = true },
                        { "<localleader>e}", "<nop>", hidden = true },
                    },
                })
            end

            vim.api.nvim_create_autocmd("FileType", {
                pattern = filetypes,
                callback = function()
                    vim.schedule(configure_which_key)
                end,
            })
        end,
    },
}
