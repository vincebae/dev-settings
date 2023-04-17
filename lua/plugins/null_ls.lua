return {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.completion.spell,
				null_ls.builtins.completion.tags,
				null_ls.builtins.diagnostics.eslint,
				null_ls.builtins.diagnostics.rust_analyzer,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.google_java_format,
				null_ls.builtins.formatting.shfmt, -- shell script formatting
				null_ls.builtins.formatting.prettier, -- markdown formatting
				null_ls.builtins.formatting.stylish_haskell,
                null_ls.builtins.formatting.rustfmt,
			},
		})
	end,
}