vim.opt.colorcolumn = "100"
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

local jdtls = require("jdtls")
local setup = require("jdtls.setup")

local mason_path = vim.fn.expand("$HOME/.local/share/nvim/mason")
local jdtls_path = mason_path .. "/bin/jdtls"
local lombok_path = mason_path .. "/packages/jdtls/lombok.jar"
local config = {
	cmd = {
		jdtls_path,
		"--jvm-arg=-javaagent:" .. lombok_path,
	},
	root_dir = setup.find_root({ ".git", "mvnw", "gradlew" }),
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
}

jdtls.start_or_attach(config)
