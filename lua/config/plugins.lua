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
local keymap = vim.keymap

keymap.set("n", "<leader>Pi", lazy.install)
keymap.set("n", "<leader>Pc", lazy.clean)
keymap.set("n", "<leader>Pu", lazy.update)
keymap.set("n", "<leader>Ps", lazy.sync)
keymap.set("n", "<leader>PS", lazy.health)
keymap.set("n", "<leader>Pp", lazy.home)

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
