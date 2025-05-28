return {
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        keys = {
            {
                "<leader>ss",
                function()
                    require("persistence").select()
                end,
                desc = "Select Session",
            },
        },
        config = function()
            require("persistence").setup({
                dir = vim.fn.stdpath("data") .. "/sessions/",
                need = 1,
                branch = false,
            })

            -- Close temporary windows before saving sessions.
            vim.api.nvim_create_autocmd("User", {
                group = vim.api.nvim_create_augroup("user-persistence", { clear = true }),
                pattern = "PersistenceSavePre",
                callback = function(_)
                    vim.cmd("cclose")
                    require("conjure.log")["close-visible"]()
                    require("dapui").close()
                end,
            })
        end,
    },
}
