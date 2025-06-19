return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        keys = {
            { "<C-t>t", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
            { "<C-t>1", "<cmd>1ToggleTerm<cr>", desc = "Toggle Terminal 1" },
            { "<C-t>2", "<cmd>2ToggleTerm<cr>", desc = "Toggle Terminal 2" },
            { "<C-t>3", "<cmd>3ToggleTerm<cr>", desc = "Toggle Terminal 3" },
            { "<C-t>4", "<cmd>4ToggleTerm<cr>", desc = "Toggle Terminal 4" },
            { "<C-t>f", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Terminal Float" },
            { "<C-t>v", "<cmd>ToggleTerm direction=vertical size=100<cr>", desc = "Toggle Terminal Vertical" },
            { "<C-t>s", "<cmd>ToggleTerm direction=horizontal size=25<cr>", desc = "Toggle Terminal Horizontal" },
            { "<C-t>", "<cmd>ToggleTerm<cr>", mode = { "t" }, buffer = 0, desc = "Toggle Terminal" },
            { "<C-t>l", "<cmd>TermSelect<cr>", desc = "Select Terminal" },
            { "<C-w>", "<C-\\><C-N><C-w>", mode = { "t" }, buffer = 0 },
            { "<esc>", [[<C-\><C-n>]], mode = { "t" }, buffer = 0 },
            { "jk", [[<C-\><C-n>]], mode = { "t" }, buffer = 0 },
            { "<C-h>", [[<Cmd>wincmd h<CR>]], mode = { "t" }, buffer = 0 },
            { "<C-j>", [[<Cmd>wincmd j<CR>]], mode = { "t" }, buffer = 0 },
            { "<C-k>", [[<Cmd>wincmd k<CR>]], mode = { "t" }, buffer = 0 },
            { "<C-l>", [[<Cmd>wincmd l<CR>]], mode = { "t" }, buffer = 0 },
            { "<C-w>", [[<C-\><C-n><C-w>]], mode = { "t" }, buffer = 0 },
            {
                "<C-t>c",
                function()
                    require("toggleterm").send_lines_to_terminal("single_line", true, { args = vim.v.count })
                end,
                desc = "Send Current Line to Terminal",
            },
            {
                "<C-t>c",
                function()
                    require("toggleterm").send_lines_to_terminal("visual_selection", false, { args = vim.v.count })
                end,
                mode = { "v" },
                desc = "Send Selected Lines to Terminal",
            },
            {
                "<leader>:",
                function()
                    local command = vim.fn.input("Send Text to Terminal: ")
                    if command and command ~= "" then
                        require("toggleterm").exec(command, 1, 20, ".", "horizontal")
                    end
                end,
                desc = "Send Text to Terminal",
            },
        },
        config = function()
            local tt = require("toggleterm")
            tt.setup({
                size = function(term)
                    if term.direction == "horizontal" then
                        return 20
                    elseif term.direction == "vertical" then
                        return vim.o.columns * 0.4
                    end
                end,
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
            })
        end,
    },
}
