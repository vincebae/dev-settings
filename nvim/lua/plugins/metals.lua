local filetypes = { "scala", "sbt" }
return {
	"scalameta/nvim-metals", -- scala language server
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	ft = filetypes,
	config = function()
		local metals = require("metals")
		local metals_config = metals.bare_config()

		metals_config.settings = {
			showImplicitArguments = true,
			excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
		}
		metals_config.capabilities = require("blink.cmp").get_lsp_capabilities()
		metals_config.init_options.statusBarProvider = "off"
		metals_config.cmd = {
			"/Users/seungbin.bae/Library/Application Support/Coursier/bin/metals"
		}

		local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function()
				require("metals").initialize_or_attach(metals_config)
			end,
			group = nvim_metals_group,
		})
	end,
}
