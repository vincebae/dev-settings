return {
    {
        "zk-org/zk-nvim",
        lazy = false,
        keys = {
            { "<leader>zz", "<cmd>ZkNotes<cr>", desc = "Zk Notes" },
            { "<leader>zt", "<cmd>ZkTags<cr>", desc = "Zk Keywords / Tags" },
            { "<leader>zk", "<cmd>ZkTags<cr>", desc = "Zk Keywords / Tags" },
            { "<leader>zl", "<cmd>ZkLinks<cr>", desc = "Zk Links" },
            { "<leader>zb", "<cmd>ZkBacklinks<cr>", desc = "Zk Backlinks" },
            {
                "<leader>zi",
                "<cmd>ZkInsertLink<cr>",
                mode = { "n" },
                desc = "Zk Insert Link",
            },
            {
                "<leader>zi",
                ":<C-u>'<,'>ZkInsertLinkAtSelection<cr>",
                mode = { "v" },
                desc = "Zk Insert Link (Selection)",
            },
            {
                "<leader>zn",
                function()
                    local su = require("utils.string_utils")
                    local text = vim.fn.input("Zk Title: ")
                    if text and text ~= "" then
                        local pu = require("utils.path_utils")
                        local opts = "{ title = "
                            .. su.make_literal(text)
                            .. ", dir = "
                            .. su.make_literal(pu.get_buffer_dir_path())
                            .. " }"
                        vim.cmd("ZkNew " .. opts)
                    end
                end,
                desc = "Zk New",
            },
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
