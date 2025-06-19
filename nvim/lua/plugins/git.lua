return {
    {
        "tpope/vim-fugitive",
        keys = {
            { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
            { "<leader>gl", "<cmd>Git log<cr>", desc = "Git Log" },
            { "<leader>gm", "<cmd>Git mergetool<cr>", desc = "Git Mergetool" },
        },
        config = function() end,
        lazy = false,
    },
    {
        "sindrets/diffview.nvim",
        keys = {
            { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diff" },
            { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close Diff" },
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
                    map("n", "]g", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "]c", bang = true })
                        else
                            gitsigns.nav_hunk("next")
                        end
                    end, { desc = "Next Git Hunk" })

                    map("n", "[g", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "[c", bang = true })
                        else
                            gitsigns.nav_hunk("prev")
                        end
                    end, { desc = "Prev Git Hunk" })

                    -- Actions
                    map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Reset Git Hunk" })
                    map("v", "<leader>gr", function()
                        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "Reset Git Hunk" })

                    map("n", "<leader>gh", gitsigns.preview_hunk_inline, { desc = "Preview Git Hunk" })
                    map("n", "<leader>gQ", function()
                        gitsigns.setqflist("all")
                    end, { desc = "Quicklist All Git Hunks" })
                    map("n", "<leader>gq", gitsigns.setqflist, { desc = "Quicklist Git Hunks" })

                    -- Toggles
                    map("n", "<leader>gt", function()
                        gitsigns.toggle_current_line_blame()
                        gitsigns.toggle_deleted()
                        gitsigns.toggle_word_diff()
                    end, { desc = "Toggle Gitsigns" })
                end,
            })
        end,
    },
}
