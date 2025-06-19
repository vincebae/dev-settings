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
        { "<localleader><localleader>r", "<cmd>SlimeConfig<cr>", desc = "Reset Slime Config" },
        { "<localleader><localleader>c", "<cmd>SlimeSendCurrentLine<cr>", desc = "Send Current Line" },
        {
            "<localleader><localleader>",
            "<Plug>SlimeRegionSend",
            mode = "v",
            desc = "Slime Send Region",
            { noremap = false },
        },
        { "<localleader><localleader>p", "<Plug>SlimeParagraphSend", desc = "Send Paragraph", { noremap = false } },
        {
            "<localleader>:",
            function()
                local my = require("utils.my_utils")
                local text = vim.fn.input("Send Text: ")
                if text and text ~= "" then
                    vim.cmd("SlimeSend0 " .. my.make_literal(text .. "\n"))
                end
            end,
            desc = "Slime Send Input Text",
        },
    },
}
