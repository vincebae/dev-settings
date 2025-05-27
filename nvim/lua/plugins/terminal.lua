vim.api.nvim_create_autocmd("FileType", {
    pattern = "toggleterm",
    callback = function()
        vim.schedule(function()
            vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm<cr>", { buffer = true, noremap = true })
        end)
    end,
})
return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        keys = {
            { "<C-t>t", "<cmd>ToggleTerm<cr>" },
            { "<C-t>f", "<cmd>ToggleTerm direction=float<cr>" },
            { "<C-t>v", "<cmd>ToggleTerm direction=vertical size=100<cr>" },
            { "<C-t>V", "<cmd>vertical bo split +terminal<cr>" },
            { "<C-t>s", "<cmd>ToggleTerm direction=horizontal size=25<cr>" },
            { "<C-t>S", "<cmd>split +terminal<cr>" },
            { "<C-t>", "<cmd>ToggleTerm<cr>", mode = { "t" } },
            { "<C-w>", "<C-\\><C-N><C-w>", mode = { "t" } },
            {
                "<C-t>c",
                function()
                    require("toggleterm").send_lines_to_terminal(
                        "single_line", true, { args = vim.v.count })
                end,
            },
            {
                "<C-t>c",
                function()
                    require("toggleterm").send_lines_to_terminal(
                        "visual_selection", false, { args = vim.v.count })
                end,
                mode = { "v" },
            },
            {
                "<leader>:",
                function()
                    local command = vim.fn.input("Send Text to Terminal: ")
                    require("toggleterm").exec(command, 1, 20, "horizontal")
                end,
            },
        },
        opts = {
            close_on_exit = true,
            float_opts = {
                width = 120,
                height = 40,
            },
            on_create = function(term)
                -- Although `close_on_exit` is set to true,
                -- opened terminal is still preserved when session is enabled.
                -- This `on_create` function will add an auto command to close the term
                -- before session is saved.
                local group = vim.api.nvim_create_augroup("user-persistence", { clear = true })
                vim.api.nvim_create_autocmd("User", {
                    group = group,
                    pattern = "PersistenceSavePre",
                    callback = function(_)
                        term:close()
                    end,
                })
            end,
        },
    },
}
