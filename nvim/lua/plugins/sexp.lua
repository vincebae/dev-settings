vim.cmd([[let g:sexp_filetypes = 'clojure,scheme,lisp,timl,fennel']])
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
        config = function() end,
    },
}
