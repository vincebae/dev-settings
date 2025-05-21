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
            "<localleader><localleader><localleader>",
            function()
                local text = vim.fn.input("Text > ")
                local escaped = ""
                for c in string.gmatch(text, ".") do
                    if c == [[\]] or c == [["]] then
                        escaped = escaped .. [[\]]
                    end
                    escaped = escaped .. c
                end
                local wrapped = [["]] .. escaped .. [[\n"]]
                vim.cmd("SlimeSend0 " .. wrapped)
            end,
        },
    },
}
