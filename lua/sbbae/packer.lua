-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- keymaps
vim.keymap.set("n", "<leader>pi", vim.cmd.PackerInstall)
vim.keymap.set("n", "<leader>pc", vim.cmd.PackerClean)
vim.keymap.set("n", "<leader>pu", vim.cmd.PackerUpdate)
vim.keymap.set("n", "<leader>ps", vim.cmd.PackerSync)
vim.keymap.set("n", "<leader>pS", vim.cmd.PackerStatus)

return require('packer').startup(function(use)
    -- Packer can manage itself
    use { 'wbthomason/packer.nvim' }

    use { 'numToStr/Comment.nvim' }
    use { 'mbbill/undotree' }
    use { 'folke/which-key.nvim' }
    use { 'tpope/vim-fugitive' }
    use { 'scrooloose/nerdtree' }
    use { 'jistr/vim-nerdtree-tabs' }

    use {
        'LunarVim/lunar.nvim',
        config = function()
            vim.cmd.colorscheme('lunar')
        end
    }

    use {
        'nvim-telescope/telescope.nvim', tag = '2.1.1',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use {
        'theprimeagen/harpoon',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    use {
        'goolord/alpha-nvim',
        requires = { 'nvim-tree/nvim-web-devicons' }
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use {
        'rmagatti/session-lens',
        requires = {
            'rmagatti/auto-session',
            'nvim-telescope/telescope.nvim'
        },
    }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },         -- Required
            { 'hrsh7th/cmp-nvim-lsp' },     -- Required
            { 'hrsh7th/cmp-buffer' },       -- Optional
            { 'hrsh7th/cmp-path' },         -- Optional
            { 'hrsh7th/cmp-nvim-lua' },     -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' },             -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    }
end)
