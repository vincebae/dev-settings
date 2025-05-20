local toggle_quickfix = function()
    if vim.bo.filetype == "qf" then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.schedule(function()
            vim.keymap.set("n", "q", "<cmd>cclose<cr>", { buffer = true, noremap = true })
        end)
    end,
})

return {
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        dependencies = {
            {
                "junegunn/fzf",
                build = function()
                    -- vim.fn["fzf#install()"]()
                end,
            },
            { "nvim-treesitter/nvim-treesitter" },
        },
        keys = {
            { "<C-q>", toggle_quickfix },
            { "<C-c>", "<cmd>cclose<cr>" },
        },
        config = function()
            require("bqf").setup({
                func_map = {
                    split = "<C-s>",
                    fzffilter = "/",
                },
                preview = {
                    winblend = 0,
                },
            })
        end,
    },
}
