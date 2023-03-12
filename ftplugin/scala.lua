local metals = require("metals")
local metals_config = metals.bare_config()

-- Example of settings
metals_config.settings = {
	showImplicitArguments = true,
	excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

-- *READ THIS*
-- I *highly* recommend setting statusBarProvider to true, however if you do,
-- you *have* to have a setting to display this in your statusline or else
-- you'll not see any messages from metals. There is more info in the help
-- docs about this
-- metals_config.init_options.statusBarProvider = "on"

-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>lD", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>lR", vim.lsp.buf.references)

vim.keymap.set("n", "<leader>ldo", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>ldn", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>ldp", vim.diagnostic.goto_prev)

metals.initialize_or_attach(metals_config)
