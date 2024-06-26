return {
	"rmagatti/session-lens",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		{
			"rmagatti/auto-session",
			opts = {
				log_level = "error",
				auto_session_suppress_dirs = {
					"~/",
					"~/Projects",
					"~/Downloads",
					"/",
				},
			},
		},
	},
	config = function()
        local auto_session = require("auto-session")
        auto_session.setup({
            auto_restore_enabled = false,
        })

		local session_lens = require("session-lens")
		session_lens.setup({
			path_display = { "shorten" },
		})

		require("telescope").load_extension("session-lens")

		local keymap = vim.keymap

		keymap.set("n", "<leader>ss", "<cmd>SessionSave<cr>")
		keymap.set("n", "<leader>sr", "<cmd>SessionRestore<cr>")
		keymap.set("n", "<leader>sd", "<cmd>Autosession delete<cr>")
		keymap.set("n", "<leader>sf", session_lens.search_session)
	end,
}
