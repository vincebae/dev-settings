local lsp = require("lsp-zero").preset({
	name = "minimal",
	set_lsp_keymaps = true,
	manage_nvim_cmp = true,
	suggest_lsp_servers = false,
})

lsp.ensure_installed({
	"tsserver",
	"lua_ls",
})

lsp.set_preferences({
	sign_icons = {},
})

-- Disable jdtls in lsp-zero
-- jdtls will be initialized by nvim.jdtls in ftplugin/java.lua
lsp.skip_server_setup({ "jdtls" })

vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>")

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)

	vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>lD", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "<leader>lR", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, opts)

	vim.keymap.set("n", "<leader>ll", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "<leader>ln", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<leader>lp", vim.diagnostic.goto_prev, opts)
end)

lsp.setup()
