return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "jbyuki/one-small-step-for-vimkind",
        },
        config = function()
            local dap = require("dap")
            local widgets = require("dap.ui.widgets")

            vim.keymap.set("n", "<leader>db", function()
                dap.toggle_breakpoint()
            end, { noremap = true })

            vim.keymap.set("n", "<leader>dc", function()
                dap.continue(false)
            end, { noremap = true })

            vim.keymap.set("n", "<leader>do", function()
                dap.step_over()
            end, { noremap = true })

            vim.keymap.set("n", "<leader>di", function()
                dap.step_into()
            end, { noremap = true })

            vim.keymap.set("n", "<leader>dt", function()
                dap.step_out()
            end, { noremap = true })

            vim.keymap.set("n", "<leader>dr", function()
                dap.repl.open()
            end, { noremap = true })

            vim.keymap.set("n", "<leader>dw", function()
                widgets.hover()
            end, { noremap = true })

            vim.keymap.set("n", "<leader>ds", function()
                widgets.centered_float(widgets.scopes)
            end, { noremap = true })

            vim.keymap.set("n", "<leader>df", function()
                widgets.centered_float(widgets.frames)
            end, { noremap = true })

            vim.keymap.set("n", "<leader>du", function()
                require("dapui").toggle()
            end, { noremap = true })

            vim.keymap.set("n", "<leader>dl", function()
                require("osv").launch({ port = 8086 })
            end, { noremap = true })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "dap-float",
                callback = function()
                    vim.schedule(function()
                        vim.keymap.set("n", "q", "<cmd>close!<CR>", { buffer = true, noremap = true })
                    end)
                end,
            })

            -- Lua
            dap.configurations.lua = {
                {
                    type = "nlua",
                    request = "attach",
                    name = "Attach to running Neovim instance",
                },
            }
            dap.adapters.nlua = function(callback, config)
                callback({
                    type = "server",
                    host = config.host or "127.0.0.1",
                    port = config.port or 8086,
                })
            end

            -- Java
            dap.configurations.java = {
                {
                    type = "java",
                    request = "attach",
                    name = "Debug (Attach) - Remote",
                    hostName = "127.0.0.1",
                    port = 5005,
                },
            }
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        opts = {}
    },
}
