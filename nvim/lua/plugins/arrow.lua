return {
	{
		"otavioschwanck/arrow.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		opts = {
			show_icons = true,
			leader_key = "<leader><space>",
			buffer_leader_key = "<leader>m",
			mappings = {
				toggle = "a",
				open_horizontal = "s",
			},
		},
	},
}
