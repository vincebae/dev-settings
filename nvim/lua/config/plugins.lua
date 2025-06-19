-- Bootstrapping lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")
vim.keymap.set("n", "<leader>Pi", lazy.install, { desc = "Install Plugins" })
vim.keymap.set("n", "<leader>Pc", lazy.clean, { desc = "Clean Plugins" })
vim.keymap.set("n", "<leader>Pu", lazy.update, { desc = "Update Plugins" })
vim.keymap.set("n", "<leader>Ps", lazy.sync, { desc = "Sync Plugins" })
vim.keymap.set("n", "<leader>PS", lazy.health, { desc = "Plugin Status" })
vim.keymap.set("n", "<leader>Pp", lazy.home, { desc = "Lazy Home" })

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    checker = {
        enabled = true,
        -- check for updates every one day.
        frequency = 86400,
    },
})
