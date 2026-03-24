return {
    {
        "zk-org/zk-nvim",
        lazy = false,
        keys = {},
        config = function()
            require("zk").setup({
                picker = "snacks_picker",
                lsp = {
                    config = {
                        name = "zk",
                        cmd = { "zk", "lsp" },
                        filetypes = { "markdown" },
                        on_attach = function(client, bufnr)
                            vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", {
                                buffer = bufnr,
                                desc = "Follow Link",
                            })
                        end,
                    },
                    auto_attach = {
                        enabled = true,
                    },
                },
            })

            local su = require("utils.string_utils")
            local pu = require("utils.popup_utils")

            local function choose_group_menu(callback)
                local title = "Choose Zk Group"
                local menuitems = {
                    { "Fleet", { value = "fleet" } },
                    { "Literature", { value = "literature" } },
                    { "Project", { value = "project" } },
                    { "Career", { value = "career" } },
                    { "Recipe", { value = "recipe" } },
                }
                local callbacks = {
                    on_submit = function(item)
                        callback(item.value)
                    end,
                }
                local opts = { width = 24 }
                pu.popup_menu(title, menuitems, callbacks, opts)
            end

            -- Keymap config
            vim.keymap.set("n", "<leader>zz", "<cmd>ZkNotes<cr>", { noremap = true, desc = "Zk Notes" })
            vim.keymap.set("n", "<leader>zl", "<cmd>ZkLinks<cr>", { noremap = true, desc = "Zk Links" })
            vim.keymap.set("n", "<leader>zb", "<cmd>ZkBacklinks<cr>", { noremap = true, desc = "Zk Backlinks" })
            vim.keymap.set("n", "<leader>zi", "<cmd>ZkInsertLink<cr>", { noremap = true, desc = "Zk Insert Link" })
            vim.keymap.set(
                "v",
                "<leader>zi",
                ":<C-u>'<,'>ZkInsertLinkAtSelection<cr>",
                { noremap = true, desc = "Zk Insert Link (Selection)" }
            )
            vim.keymap.set(
                "n",
                "<leader>zk",
                "<cmd>ZkTags<cr>",
                { noremap = true, desc = "Zk Keywords / Tags (Simple)" }
            )
            vim.keymap.set("n", "<leader>zK", function()
                local text = vim.fn.input("Zk Keywords / Tags: ")
                if text and text ~= "" then
                    local opts = "{ tags = { " .. su.make_literals(text, ",") .. " } }"
                    vim.cmd("ZkNotes " .. opts)
                end
            end, { noremap = true, desc = "Zk Keywords / Tags (Full)" })
            vim.keymap.set("n", "<leader>zg", function()
                choose_group_menu(function(group)
                    vim.notify("Zk group set to: " .. group)
                end)
            end, { noremap = true, desc = "Zk Choose Group" })
            vim.keymap.set("n", "<leader>zn", function()
                local text = vim.fn.input("Zk New Note Title: ")
                if text and text ~= "" then
                    choose_group_menu(function(group)
                        local title = su.make_literal(text)
                        local opts = "{ title = " .. title .. ', group = "' .. group .. '" }'
                        vim.cmd("ZkNew " .. opts)
                    end)
                end
            end, { noremap = true, desc = "Zk New Note" })
            vim.keymap.set("v", "<leader>zn", function()
                choose_grou_menu(function(group)
                    local opts = '{ group = "' .. group .. '" }'
                    vim.cmd("'<,'>ZkNewFromTitleSelection " .. opts)
                end)
            end, { noremap = true, desc = "Zk New from Title" })
        end,
    },
}
