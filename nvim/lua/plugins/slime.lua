return {
    "jpalardy/vim-slime",
    lazy = false,
    config = function()
        vim.g.slime_target = "tmux"
        vim.g.slime_no_mappings = 1
        vim.g.slime_dont_ask_default = 1
        vim.g.slime_default_config = {socket_name = "default", target_pane = "+1"}

        vim.cmd([[xmap <localleader><localleader><localleader> <Plug>SlimeRegionSend]])
        vim.cmd([[nmap <localleader><localleader>p <Plug>SlimeParagraphSend]])
    end,
    keys = {
        { "<localleader><localleader>r", "<cmd>SlimeConfig<cr>" },
        { "<localleader><localleader>c", "<cmd>SlimeSendCurrentLine<cr>" },
        {
            "<localleader><localleader>:",
            function()
                local my = require("utils.my_utils")
                local text = vim.fn.input("Send Text: ")
                vim.cmd("SlimeSend0 " .. my.make_literal(text, { newline = true }))
            end,
        },
    },
}
