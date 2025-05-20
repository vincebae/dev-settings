return {
    "folke/which-key.nvim",
    config = function()
        local which_key = require("which-key")
        local setup = {
            preset = "modern",
            triggers = {
                { "<leader>", mode = { "n", "v" } },
                { "<localleader>", mode = { "n", "v" } },
                { "g", mode = { "n" } },
                { "z", mode = { "n", "v" } },
                { "<C-t>", mode = { "n" } },
                { "<C-w>", mode = { "n" } },
            },
        }
        which_key.setup(setup)

        which_key.add({
            -- leader + single key mappings
            { "<leader>a", desc = "Toggle Aerial" }, -- defined in aerial.lua
            { "<leader>F", desc = "Format" }, -- defined in formatter.lua
            { "<leader>X", desc = "Make executable" }, -- defined in keymap.lua
            { "<leader>y", desc = "Yank to Clipboard" }, -- defined in keymap.lua
            { "<leader>f", desc = "Smart Open Files" }, -- defined in snacks.lua
            { "<leader>G", desc = "Grep Word" }, -- defined in snacks.lua
            { "<leader>t", desc = "Toggle Test" }, --defined in keymap.lua
            { "<leader>M", desc = "Open Memo" }, --defined in maple.lua
            { "<leader>-", desc = "Move to CWD" }, -- defined in keymap.lua
            { "<leader>/", desc = "Live Grep" }, -- defined in snacks.lua
            { "<leader>.", desc = "Live Grep at Curr Dir" }, -- defined in snacks.lua
            { "<leader>`", desc = "Toggle Lua Console" }, -- defined in luaconsole.lua
            { "<leader>~", desc = "Attach to Lua Console" }, -- defined in luaconsole.lua
            { "<leader> ", desc = "Open Arrow" }, -- defined in arrow.lua

            -- Visual mode key mappings
            {
                mode = { "v" },
                { "<leader> ", desc = "Comment line(s)" }, -- defined in Comment.lua
                { "<leader>y", desc = "Yank to Clipboard" }, -- defined in keymap.lua
            },

            { "<leader>b", group = "Buffer" },
            {
                { "<leader>bb", desc = "List" }, -- defined in snacks.lua
                { "<leader>bh", desc = "Show Histories" }, -- defined in buffer.lua
                { "<leader>br", desc = "Reset Curr History" }, -- defined in buffer.lua
                { "<leader>bR", desc = "Reset All Histories" }, -- defined in buffer.lua
                { "<leader>bd", desc = "Delete Other Buffers" }, --defined in buffer.lua
            },

            { "<leader>d", group = "DAP" },
            {
                { "<leader>db", desc = "Breakpoint" },
                { "<leader>dc", desc = "Continue" },
                { "<leader>do", desc = "Step Over" },
                { "<leader>di", desc = "Step Into" },
                { "<leader>dt", desc = "Step Out" },
                { "<leader>dr", desc = "Open Repl" },
                { "<leader>dw", desc = "Widget" },
                { "<leader>ds", desc = "Scope" },
                { "<leader>df", desc = "Frame" },
                { "<leader>du", desc = "Toggle DAP UI" },
                { "<leader>dl", desc = "Start Lua Debug Server" },
            },

            -- defined in git.lua
            { "<leader>g", group = "Git" },
            {
                -- { "<leader>gg", desc = "Neogit" },
                { "<leader>gg", desc = "LazyGit" },
                { "<leader>gs", desc = "Status" },
                { "<leader>gb", desc = "Blame" },
                { "<leader>gl", desc = "Log" },
                { "<leader>gm", desc = "Mergetool" },
                { "<leader>gd", desc = "Diff open" },
                { "<leader>gc", desc = "Diff close" },
                { "<leader>gr", desc = "Reset Hunk" },
                { "<leader>gh", desc = "Preview Hunk Inline" },
                { "<leader>gq", desc = "Quicklist Hunks" },
                { "<leader>gQ", desc = "Quicklist All Hunks" },
                { "<leader>gt", desc = "Toggle Gitsigns" },
            },
            {
                mode = { "v" },
                { "<leader>g", group = "Git" },
                { "<leader>gr", desc = "Reset Hunks" },
            },

            -- defined in keymap.lua
            { "<leader>p", group = "Paste" },
            {
                { "<leader>pc", desc = "Clipboard" },
                { "<leader>py", desc = "Yanked" },
                { "<leader>pd", desc = "Last deleted" },
            },

            -- defined in lazy.lua
            { "<leader>P", group = "Plugins" },
            {
                { "<leader>Pi", desc = "Install" },
                { "<leader>Pc", desc = "Clean" },
                { "<leader>Pu", desc = "Update" },
                { "<leader>Ps", desc = "Sync" },
                { "<leader>PS", desc = "Status" },
                { "<leader>Pp", desc = "Plugins" },
            },

            -- defined in snacks.lua, mostly
            { "<leader>s", group = "Snacks" },
            {
                { "<leader>sb", desc = "Buffers" },
                { "<leader>sc", desc = "Colorschemes" },
                { "<leader>sj", desc = "Jumps" },
                { "<leader>sk", desc = "Keymaps" },
                { "<leader>sn", desc = "Notifications" },
                { "<leader>sp", desc = "Projects" },
                { "<leader>sq", desc = "Quickfix" },
                { "<leader>sr", desc = "Resumes" },
                { "<leader>ss", desc = "Sessions" }, -- defined in session.lua
                { "<leader>su", desc = "Undo" },
            },

            -- defined in terminal.lua
            { "<C-t>", group = "Terminal" },
            {
                { "<C-t>t", desc = "Toggle Term" },
                { "<C-t>f", desc = "ToggleTerm Float" },
                { "<C-t>v", desc = "ToggleTerm Vertical" },
                { "<C-t>V", desc = "Terminal Vertical" },
                { "<C-t>s", desc = "ToggleTerm Horizontal" },
                { "<C-t>S", desc = "Terminal Horizontal" },
            },

            -- defined in lsp.lua
            {
                { "gd", desc = "LSP definition" },
                { "gr", desc = "LSP references" },
                { "gi", desc = "LSP implementation" },
            },
        })
    end,
}
