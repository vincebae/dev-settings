return {
	"mfussenegger/nvim-jdtls", -- java language server
	ft = { "java" }, -- "scala", "sbt" },
	config = function()
		local jdtls = require("jdtls")
		local setup = require("jdtls.setup")

		local jdtls_path = "/home/linuxbrew/.linuxbrew/bin/jdtls"
		local project_root = setup.find_root({ ".git", "mvnw", "gradlew", "build.sbt" })
		local project_name = vim.fn.fnamemodify(project_root, ":p:h:t")
		local cache_dir = vim.fn.expand("$HOME/.cache/jdtls")
		local data_dir = cache_dir .. "/workspace/" .. project_name
		local config_dir = cache_dir .. "/config/"

		local config = {
			cmd = {
				jdtls_path,
				"-configuration",
				config_dir,
				"-data",
				data_dir,
				-- "--jvm-arg=-javaagent:" .. lombok_path,
			},
			root_dir = project_root,
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		}

		jdtls.start_or_attach(config)
	end,
}
