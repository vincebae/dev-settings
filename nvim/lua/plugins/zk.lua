return {
    {
        "zk-org/zk-nvim",
        keys = {
            { "<leader>zb", "<cmd>ZkBuffers<cr>", desc = "Zk Buffers" },
            { "<leader>zn", "<cmd>ZkNotes<cr>", desc = "Zk Notes" },
            { "<leader>zt", "<cmd>ZkTags<cr>", desc = "Zk Tags" },
        },
        config = function()
            require("zk").setup({
                picker = "snacks_picker",
                lsp = {
                    -- `config` is passed to `vim.lsp.start(config)`
                    config = {
                        name = "zk",
                        cmd = { "zk", "lsp" },
                        filetypes = { "markdown" },
                        -- on_attach = ...
                        -- etc, see `:h vim.lsp.start()`
                    },

                    -- automatically attach buffers in a zk notebook that match the given filetypes
                    auto_attach = {
                        enabled = true,
                    },
                },
            })
        end,
    },
}
