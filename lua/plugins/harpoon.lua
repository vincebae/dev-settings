return {
    "theprimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")
        local keymap = vim.keymap

        keymap.set("n", "<leader>ha", mark.add_file)
        keymap.set("n", "<leader>hh", ui.toggle_quick_menu)

        keymap.set("n", "<leader>h1", function()
            ui.nav_file(1)
        end)
        keymap.set("n", "<leader>h2", function()
            ui.nav_file(2)
        end)
        keymap.set("n", "<leader>h3", function()
            ui.nav_file(3)
        end)
        keymap.set("n", "<leader>h4", function()
            ui.nav_file(4)
        end)

        keymap.set("n", "<leader>hn", ui.nav_next)
        keymap.set("n", "<leader>hp", ui.nav_prev)

        local harpoon = require("harpoon")
        harpoon.setup({
            menu = {
                width = vim.api.nvim_win_get_width(0) - 10,
            },
        })
    end,
}
