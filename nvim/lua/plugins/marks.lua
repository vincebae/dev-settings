return {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {
        mappings = {
            pref = "[m",
            next = "]m",
        },
    },
    keys = {
        { "m/", "<cmd>MarksQFListBuf<cr>" },
    },
}
