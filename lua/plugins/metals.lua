return {
	"scalameta/nvim-metals", -- scala language server
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	ft = { "scala", "sbt" },
	config = function()
		local metals = require("metals")
		local metals_config = metals.bare_config()

		metals_config.settings = {
			showImplicitArguments = true,
			excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
		}
		metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
		metals_config.init_options.statusBarProvider = "off"
		metals_config.cmd = {
			"/home/vincebae/.local/share/coursier/bin/metals",
		}

		local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "scala", "sbt" },
			callback = function()
				require("metals").initialize_or_attach(metals_config)
			end,
			group = nvim_metals_group,
		})
	end,
}
