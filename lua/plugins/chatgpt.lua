return {
    "jackMort/ChatGPT.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim",
        "nvim-telescope/telescope.nvim"
    },
    event = "VeryLazy",
    config = function()
        local home = vim.fn.expand("$HOME")
        require("chatgpt").setup({
            -- api_host_cmd = 'echo -n ""',
            api_key_cmd = home .. "/bin/echo_gpt_key.sh"
        })
    end,
}
