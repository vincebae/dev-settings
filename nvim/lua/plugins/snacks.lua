local function fortune()
    local openPop = assert(io.popen("fortune -s | cowsay -r", "r"))
    local output = openPop:read("*all")
    openPop:close()
    return output
end

return {
    {
        "folke/snacks.nvim",
        lazy = false,
        opts = {
            styles = {
                notification = {
                    wo = {
                        winblend = 0,
                    },
                },
            },
            bufdelete = {
                enabled = true,
            },
            dashboard = {
                preset = {
                    header = fortune(),
                },
                sections = {
                    { section = "header" },
                    { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                    { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
                    { section = "startup" },
                },
            },
            explorer = {
                enabled = true,
                replace_netrw = false,
            },
            lazygit = {
                enabled = true,
            },
            notifier = {
                enabled = true,
                width = { min = 50, max = 0.8 },
            },
            picker = {
                enabled = true,
                layout = {
                    cycle = true,
                    preset = function()
                        if vim.o.columns <= 160 then
                            return "vertical"
                        elseif vim.o.lines >= 50 then
                            return "ivy"
                        else
                            return "default"
                        end
                    end,
                    layout = {
                        width = 0.8,
                    },
                },
                main = {
                    file = false,
                },
                win = {
                    -- input window
                    input = {
                        keys = {
                            ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
                            ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
                            ["<c-p>"] = { "toggle_preview", mode = { "i", "n" } },
                            ["<c-w>"] = { "cycle_win", mode = { "i", "n" } },
                        },
                    },
                    list = {
                        keys = {
                            ["<c-d>"] = "preview_scroll_down",
                            ["<c-u>"] = "preview_scroll_up",
                            ["<c-p>"] = "toggle_preview",
                            ["<c-w>"] = "cycle_win",
                        },
                    },
                    preview = {
                        keys = {
                            ["<c-w>"] = "cycle_win",
                        },
                    },
                },
            },
            rename = {
                enabled = true,
            },
            words = {
                enabled = false,
            },
        },
        keys = {
            {
                "<c-e>",
                function()
                    Snacks.explorer({
                        layout = {
                            preset = function()
                                return vim.o.columns >= 160 and "default" or "vertical"
                            end,
                            preview = true,
                            layout = {
                                width = 0.8,
                            },
                        },
                        auto_close = true,
                    })
                end,
                desc = "Toggle Explorer",
            },
            {
                "<leader>c",
                function()
                    Snacks.notifier.hide()
                end,
                desc = "Clear All Notification",
            },
            {
                "<leader>gg",
                function()
                    Snacks.lazygit()
                end,
                desc = "Lazygit",
            },
            {
                "<leader>f",
                function()
                    Snacks.picker.smart()
                end,
                desc = "Smart Find Files",
            },
            {
                "<leader>/",
                function()
                    Snacks.picker.grep()
                end,
                desc = "Grep",
            },
            {
                "<leader>.",
                function()
                    local path_utils = require("utils.path_utils")
                    local buffer_dir = path_utils.get_buffer_dir_path()
                    Snacks.picker.grep({ dirs = { buffer_dir } })
                end,
                desc = "Grep Current Dir",
            },
            {
                "<leader>G",
                function()
                    Snacks.picker.grep_word()
                end,
                desc = "Grep Word",
                mode = { "n", "x" },
            },
            {
                "<leader>gs",
                function()
                    Snacks.picker.git_status()
                end,
                desc = "Git Status",
            },
            {
                "<leader>bb",
                function()
                    Snacks.picker.buffers()
                end,
                desc = "Show Buffers",
            },
            {
                "<leader>sb",
                function()
                    Snacks.picker.buffers()
                end,
                desc = "Buffers",
            },

            {
                "<leader>sc",
                function()
                    Snacks.picker.colorschemes()
                end,
                desc = "Colorschemes",
            },
            {
                "<leader>sg",
                function()
                    Snacks.picker.git_status()
                end,
                desc = "Git Status",
            },
            {
                "<leader>sj",
                function()
                    Snacks.picker.jumps()
                end,
                desc = "Jumps",
            },
            {
                "<leader>sk",
                function()
                    Snacks.picker.keymaps()
                end,
                desc = "Keymaps",
            },
            {
                "<leader>sm",
                function()
                    Snacks.picker.marks({["local"] = false})
                end,
                desc = "Global Marks",
            },
            {
                "<leader>sn",
                function()
                    Snacks.picker.notifications()
                end,
                desc = "Notifications",
            },
            {
                "<leader>sp",
                function()
                    Snacks.picker.projects()
                end,
                desc = "Projects",
            },
            {
                "<leader>sq",
                function()
                    Snacks.picker.qflist()
                end,
                desc = "Quickfix List",
            },
            {
                "<leader>sr",
                function()
                    Snacks.picker.resume()
                end,
                desc = "Resumes",
            },
            {
                "<leader>su",
                function()
                    Snacks.picker.undo()
                end,
                desc = "Undo List",
            },
            {
                "gk",
                function()
                    Snacks.words.jump(1, true)
                end,
                desc = "Jump Forward",
            },
            {
                "gj",
                function()
                    Snacks.words.jump(-1, true)
                end,
                desc = "Jump Backward",
            },
        },
    },
}
