return {
    {
        "Olical/conjure",
        ft = {
            "clojure",
            "fennel",
            "lua",
            "python",
        },
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                dependencies = {
                    "nvim-treesitter",
                },
                config = function()
                end,
            },
        },
        config = function()
            -- Evaluate text from the user input
            local eval_text = function()
                local expr = vim.fn.input("Expr > ")
                vim.cmd("ConjureEval " .. expr)
            end
            vim.keymap.set("n", "<localleader>e\\", eval_text)

            -- Connect to the port from the user input
            local connect_to_port = function()
                local port = vim.fn.input("Port > ", "")
                vim.cmd("ConjureConnect " .. port)
            end
            vim.keymap.set("n", "<localleader>cp", connect_to_port)

            vim.g["conjure#extract#tree_sitter#enabled"] = true
            vim.g["conjure#log#hud#open_when"] = "log-win-not-visible"

            local which_key = require("which-key")
            which_key.add({
                { "<localleader>c", group = "Conjure Connection" },
                {
                    { "<localleader>cd", desc = "Disconnect" },
                    { "<localleader>cf", desc = "Connect to .nrepl-port" },
                    { "<localleader>cp", desc = "Connect to specific port" },
                },
                { "<localleader>E", mode = { "n" }, desc = "Evaluate motion" },
                { "<localleader>E", mode = { "v" }, desc = "Evaluate visual select" },
                { "<localleader>e", group = "Evaluate" },
                {
                    { "<localleader>ee", desc = "Innermost" },
                    { "<localleader>er", desc = "Outermost" },
                    { "<localleader>ew", desc = "Word" },
                    { "<localleader>ef", desc = "File" },
                    { "<localleader>eb", desc = "Buffer" },
                    { "<localleader>ei", desc = "Interrupt" },
                    { "<localleader>e\\", desc = "Input text" },
                    { "<localleader>ed", desc = "Doc" },
                    { "<localleader>e!", desc = "Eval and replace" },
                },
                { "<localleader>ec", group = "Evaluate and comment" },
                {
                    { "<localleader>ece", desc = "Innermost" },
                    { "<localleader>ecr", desc = "Outermost" },
                    { "<localleader>ecw", desc = "Word" },
                },
                { "<localleader>l", group = "Log buffer" },
                {
                    { "<localleader>ls", desc = "Split down" },
                    { "<localleader>lv", desc = "Split right" },
                    { "<localleader>lt", desc = "New tab" },
                    { "<localleader>le", desc = "Current window" },
                    { "<localleader>lq", desc = "Close all in tab" },
                    { "<localleader>lr", desc = "Soft reset" },
                    { "<localleader>lR", desc = "Hard reset" },
                    { "<localleader>ll", desc = "Latest result" },
                },
                { "<localleader>r", group = "Refresh" },
                {
                    { "<localleader>rr", desc = "All changed" },
                    { "<localleader>ra", desc = "All" },
                    { "<localleader>rc", desc = "Clear cache" },
                },
                { "<localleader>s", group = "REPL Session" },
                { "<localleader>t", group = "Testing" },
                {
                    { "<localleader>ta", desc = "All loaded" },
                    { "<localleader>tn", desc = "All curr ns" },
                    { "<localleader>tN", desc = "All alt ns" },
                    { "<localleader>tc", desc = "Cursor" },
                },
                { "<localleader>v", group = "View" },
                {
                    { "<localleader>ve", desc = "Last exception" },
                    { "<localleader>vs", desc = "Source" },
                    { "<localleader>v1", desc = "Most recent eval" },
                    { "<localleader>v2", desc = "2nd Most recent eval" },
                    { "<localleader>v3", desc = "3rd Most recent eval" },
                },
            })
        end,
    },
}
