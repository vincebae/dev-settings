local lazy = require("lazy")
local keymap = vim.keymap

keymap.set("n", "<leader>pi", lazy.install)
keymap.set("n", "<leader>pc", lazy.clean)
keymap.set("n", "<leader>pu", lazy.update)
keymap.set("n", "<leader>ps", lazy.sync)
keymap.set("n", "<leader>pS", lazy.health)
keymap.set("n", "<leader>pp", lazy.home)


