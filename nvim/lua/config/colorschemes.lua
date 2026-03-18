-- Randomly choose a colorscheme from the list.
local colorschemes = {
    "catppuccin-mocha",
    "duskfox",
    "gruvbox-baby",
    "iceberg",
    "lunar",
    "mellow",
    "noctis_viola",
    "nord",
    "rose-pine-main",
    "sequoia-ember",
    "sequoia-main",
    "sequoia-moss",
    "sequoia-night",
    "tokyonight",
}
local chosen = colorschemes[math.random(#colorschemes)]
vim.cmd.colorscheme(chosen)
vim.notify("Colorscheme: " .. chosen)
