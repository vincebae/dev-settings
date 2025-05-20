return {
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			--Please make sure you install markdown and markdown_inline parser
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			finder = {
				keys = {
					toggle_or_open = "<cr>",
					vsplit = "v",
					split = "s",
				},
			},
            rename = {
                in_select = false,
                keys = {
                    quit = { "q", "<C-c>", "<ESC>" },
                },
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
			symbol_in_winbar = {
				enable = false,
			},
		},
	},
}
