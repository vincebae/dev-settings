return {
    {
        "gpanders/nvim-parinfer",
        ft = {
            "clojure",
            "fennel",
        },
        config = function()
            vim.g["parinfer_mode"] = "paren"
        end,
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
            require("rainbow-delimiters.setup").setup({
                strategy = {
                    [""] = "rainbow-delimiters.strategy.global",
                    vim = "rainbow-delimiters.strategy.local",
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                },
                priority = {
                    [""] = 110,
                    lua = 210,
                },
                highlight = {
                    "RainbowDelimiterRed",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
            })
        end,
    },
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
        version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        opts = {},
    },
}
