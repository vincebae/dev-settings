return {
    {
        "tpope/vim-fugitive",
        keys = {
            { "<leader>gb", "<cmd>Git blame<cr>" },
            { "<leader>gl", "<cmd>Git log<cr>" },
            { "<leader>gm", "<cmd>Git mergetool<cr>" },
        },
        config = function() end,
        lazy = false,
    },
    {
        "sindrets/diffview.nvim",
        keys = {
            { "<leader>gd", "<cmd>DiffviewOpen<cr>" },
            { "<leader>gc", "<cmd>DiffviewClose<cr>" },
        },
        opts = {},
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            local gitsigns = require("gitsigns")
            gitsigns.setup({
                on_attach = function(bufnr)
                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]c", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "]c", bang = true })
                        else
                            gitsigns.nav_hunk("next")
                        end
                    end)

                    map("n", "[c", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "[c", bang = true })
                        else
                            gitsigns.nav_hunk("prev")
                        end
                    end)

                    -- Actions
                    map("n", "<leader>gr", gitsigns.reset_hunk)
                    map("v", "<leader>gr", function()
                        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end)

                    map("n", "<leader>gh", gitsigns.preview_hunk_inline)
                    map("n", "<leader>gQ", function()
                        gitsigns.setqflist("all")
                    end)
                    map("n", "<leader>gq", gitsigns.setqflist)

                    -- Toggles
                    map("n", "<leader>gt", function()
                        gitsigns.toggle_current_line_blame()
                        gitsigns.toggle_deleted()
                        gitsigns.toggle_word_diff()
                    end)
                end,
            })
        end,
    },
}
