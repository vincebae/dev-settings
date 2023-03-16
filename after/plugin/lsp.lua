local lsp = require("lsp-zero").preset({
	name = "minimal",
	set_lsp_keymaps = true,
	manage_nvim_cmp = true,
	suggest_lsp_servers = false,
})

lsp.set_preferences({
	sign_icons = {},
})

-- Disable jdtls in lsp-zero
-- jdtls will be initialized by nvim.jdtls in ftplugin/java.lua
lsp.skip_server_setup({ "jdtls" })

local keymap = vim.keymap

keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>")

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	local lsp = vim.lsp
	local diagnostic = vim.diagnostic

	keymap.set("n", "<leader>f", lsp.buf.format, opts)

	keymap.set("n", "<leader>la", lsp.buf.code_action, opts)
	keymap.set("n", "<leader>lr", lsp.buf.rename, opts)
	keymap.set("n", "<leader>lD", lsp.buf.definition, opts)
	keymap.set("n", "<leader>lR", lsp.buf.references, opts)
	keymap.set("n", "<leader>lh", lsp.buf.hover, opts)

	keymap.set("n", "<leader>ll", diagnostic.open_float, opts)
	keymap.set("n", "<leader>ln", diagnostic.goto_next, opts)
	keymap.set("n", "<leader>lp", diagnostic.goto_prev, opts)
end)

lsp.setup()
