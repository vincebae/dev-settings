return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			clojure = {
				"clj-kondo",
			},
			javascript = {
				"eslint_d",
			},
			javascriptreact = {
				"eslint_d",
			},
			python = {
				"flake8",
			},
			typescript = {
				"eslint_d",
			},
			typescriptreact = {
				"eslint_d",
			},
		}
		vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
			callback = function()
				local lint_status, l = pcall(require, "lint")
				if lint_status then
					l.try_lint()
				end
			end,
		})
	end,
}
