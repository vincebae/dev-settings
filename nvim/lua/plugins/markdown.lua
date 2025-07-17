return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = function()
            require("lazy").load({ plugins = { "markdown-preview.nvim" } })
            vim.fn["mkdp#util#install"]()
        end,
        config = function()
            vim.cmd([[do FileType]])
        end,
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { 
            "nvim-treesitter/nvim-treesitter", 
            "nvim-tree/nvim-web-devicons" 
        },
        opts = {},
    },
}
