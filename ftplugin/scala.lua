local metals = require("metals")
local metals_config = metals.bare_config()

-- Example of settings
metals_config.settings = {
	showImplicitArguments = true,
	excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- *READ THIS*
-- I *highly* recommend setting statusBarProvider to true, however if you do,
-- you *have* to have a setting to display this in your statusline or else
-- you'll not see any messages from metals. There is more info in the help
-- docs about this
-- metals_config.init_options.statusBarProvider = "on"

-- Example if you are using cmp how to make sure the correct capabilities for snippets are set

metals.initialize_or_attach(metals_config)

-- Java LSP
local jdtls = require("jdtls")
local setup = require("jdtls.setup")

local jdtls_path = "/home/linuxbrew/.linuxbrew/bin/jdtls"
local project_root = setup.find_root({ ".git", "mvnw", "gradlew" })
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

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets(nil, {
	scala = {
		s("shebang", {
            t({ "#!/usr/bin/env -S scala-cli shebang -S 3 --bloop-version 1.5.12-sc-1", ""}),
			-- t({ "#!/usr/bin/env amm", "" }),
		}),
	},
})
