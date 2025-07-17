return {
    "jpalardy/vim-slime",
    lazy = false,
    config = function()
        vim.g.slime_target = "tmux"
        vim.g.slime_no_mappings = 1
        vim.g.slime_dont_ask_default = 1
        vim.g.slime_default_config = { socket_name = "default", target_pane = "+1" }
    end,
    keys = {
        {
            "<leader>S",
            "<cmd>SlimeSendCurrentLine<cr>",
            desc = "Slime Send Current Line",
        },
        {
            "<leader>S",
            "<Plug>SlimeRegionSend",
            mode = { "v" },
            desc = "Slime Send Region",
            { noremap = false },
        },
        {
            "!",
            function()
                local su = require("utils.string_utils")
                local text = vim.fn.input("Send Text: ")
                if text and text ~= "" then
                    vim.cmd("SlimeSend0 " .. su.make_literal(text .. "\n"))
                end
            end,
            desc = "Slime Send Input Text",
        },
    },
}
