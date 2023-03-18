return {
	"catppuccin/nvim",
	"folke/tokyonight.nvim",
	"ellisonleao/gruvbox.nvim",
    "cocopon/iceberg.vim",
	{
		"LunarVim/lunar.nvim",
		config = function()
			vim.cmd([[colorscheme lunar]])
		end,
	},
}
