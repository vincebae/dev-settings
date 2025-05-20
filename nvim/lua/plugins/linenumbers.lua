return {
    "shrynx/line-numbers.nvim",
    opts = {
        mode = "both", -- "relative", "absolute", "both", "none"
        format = "abs_rel", -- or "rel_abs"
        separator = " ",
        rel_highlight = { link = "CursorLineNr" },
        abs_highlight = { link = "LineNr" },
    },
}
