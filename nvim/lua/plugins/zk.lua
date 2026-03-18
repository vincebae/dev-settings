return {
    {
        "zk-org/zk-nvim",
        lazy = false,
        keys = {
            { "<leader>zz", "<cmd>ZkNotes<cr>", desc = "Zk Notes" },
            { "<leader>zl", "<cmd>ZkLinks<cr>", desc = "Zk Links" },
            { "<leader>zb", "<cmd>ZkBacklinks<cr>", desc = "Zk Backlinks" },
            {
                "<leader>zi",
                "<cmd>ZkInsertLink<cr>",
                mode = { "n" },
                desc = "Zk Insert Link",
            },
            {
                "<leader>zi",
                ":<C-u>'<,'>ZkInsertLinkAtSelection<cr>",
                mode = { "v" },
                desc = "Zk Insert Link (Selection)",
            },
            { "<leader>zk", "<cmd>ZkTags<cr>", desc = "Zk Keywords / Tags (Simple)" },
            {
                "<leader>zK",
                function()
                    local su = require("utils.string_utils")

                    local function trim(s)
                        return (s:gsub("^%s*(.-)%s*$", "%1"))
                    end

                    local function process_string(input_str)
                        local items = {}
                        -- 1. Split the string into a table using string.gmatch, accounting for optional spaces around the comma
                        -- The pattern "[^,]+" matches one or more characters that are not a comma
                        for item in string.gmatch(input_str, "([^,]+)") do
                            -- 2. Trim whitespaces from each item and add it to the table
                            local trimmed_item = trim(item)
                            table.insert(items, trimmed_item)
                        end

                        -- 3. Wrap each item with double quotes
                        for i, v in ipairs(items) do
                            -- Use string concatenation ".." to add quotes
                            items[i] = su.make_literal(v)
                        end

                        -- 4. Join the items using a comma as a delimiter
                        local result = table.concat(items, ", ")
                        return result
                    end

                    local text = vim.fn.input("Zk Keywords / Tags: ")
                    if text and text ~= "" then
                        local opts = "{ tags = { " .. process_string(text) .. " } }"
                        vim.cmd("ZkNotes " .. opts)
                    end
                end,
                desc = "Zk Keywords / Tags (Full)",
            },
            {
                "<leader>zN",
                function()
                    local su = require("utils.string_utils")
                    local text = vim.fn.input("Zk New (Root) Note Title: ")
                    if text and text ~= "" then
                        local opts = "{ title = " .. su.make_literal(text) .. "}"
                        vim.cmd("ZkNew " .. opts)
                    end
                end,
                desc = "Zk New (Root Dir)",
            },
            {
                "<leader>zn",
                function()
                    local su = require("utils.string_utils")
                    local text = vim.fn.input("Zk New (Curr) Note Title: ")
                    if text and text ~= "" then
                        local pu = require("utils.path_utils")
                        local opts = "{ title = "
                            .. su.make_literal(text)
                            .. ", dir = "
                            .. su.make_literal(pu.get_buffer_dir_path())
                            .. "}"
                        vim.cmd("ZkNew " .. opts)
                    end
                end,
                desc = "Zk New (Curr Dir)",
            },
        },
        config = function()
            require("zk").setup({
                picker = "snacks_picker",
                lsp = {
                    -- `config` is passed to `vim.lsp.start(config)`
                    config = {
                        name = "zk",
                        cmd = { "zk", "lsp" },
                        filetypes = { "markdown" },
                        -- on_attach = ...
                        -- etc, see `:h vim.lsp.start()`
                    },

                    -- automatically attach buffers in a zk notebook that match the given filetypes
                    auto_attach = {
                        enabled = true,
                    },
                },
            })
        end,
    },
}
