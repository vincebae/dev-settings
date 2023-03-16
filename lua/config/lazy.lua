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

require("lazy").setup({
    "numToStr/Comment.nvim",
    "mbbill/undotree",
    "folke/which-key.nvim",
    "tpope/vim-fugitive",
    "scrooloose/nerdtree",
    "jistr/vim-nerdtree-tabs",
    "mfussenegger/nvim-jdtls",
    "LunarVim/lunar.nvim",
    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "BurntSushi/ripgrep",
        },
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    {
        "theprimeagen/harpoon",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
    },
    {
        "rmagatti/session-lens",
        dependencies = {
            "rmagatti/auto-session",
            "nvim-telescope/telescope.nvim",
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            { "williamboman/mason.nvim" },  -- Optional
        },
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },    -- Required
            { "williamboman/mason.nvim" },  -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },         -- Required
            { "hrsh7th/cmp-nvim-lsp" },     -- Required
            { "hrsh7th/cmp-buffer" },       -- Optional
            { "hrsh7th/cmp-path" },         -- Optional
            { "hrsh7th/cmp-nvim-lua" },     -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            -- Snippets
            { "L3MON4D3/LuaSnip" },         -- Required
            { "rafamadriz/friendly-snippets" }, -- Optional
        },
    },
    {
        "scalameta/nvim-metals",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "mrcjkb/haskell-tools.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim", -- optional
        },
        branch = "1.x.x",           -- recommended
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
