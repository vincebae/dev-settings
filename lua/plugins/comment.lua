return {
    "numToStr/Comment.nvim",
    config = function()
        vim.keymap.set("n", "<leader>/", require("Comment.api").toggle.linewise.current)
        vim.keymap.set(
            "v",
            "<leader>/",
            "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>"
        )
        require("Comment").setup()
    end,
}
