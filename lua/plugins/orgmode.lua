return {
	"nvim-orgmode/orgmode",
	dependencies = {
        "dhruvasagar/vim-table-mode",
        {
            "akinsho/org-bullets.nvim",
            opts = {},
        },
		{
			"lukas-reineke/headlines.nvim",
			dependencies = "nvim-treesitter/nvim-treesitter",
            opts = {},
		},
	},
	config = function()
		local orgmode = require("orgmode")
		orgmode.setup_ts_grammar()
		orgmode.setup({
			org_agenda_files = { "~/Documents/org/**/*" },
			org_default_notes_file = "~/Documents/org/memo.org",
		})
	end,
}
