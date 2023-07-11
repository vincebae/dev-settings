return {
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			--Please make sure you install markdown and markdown_inline parser
			{ "nvim-treesitter/nvim-treesitter" },
		},
		opts = {
            finder = {
                toggle_or_open = "<CR>",
                vsplit = "v",
                split = "s",
                tabnew = "n",
            },
            lightbulb = {
                enable = false,
            },
            implement = {
                enable = false,
            },
            beacon = {
                enable = false,
            },
        },
	},
}
