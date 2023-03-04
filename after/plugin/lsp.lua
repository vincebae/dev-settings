local lsp = require('lsp-zero').preset({
    name = 'minimal',
    set_lsp_keymaps = true,
    manage_nvim_cmp = true,
    suggest_lsp_servers = false,
})

lsp.ensure_installed({
    'jdtls',
    'tsserver',
    'lua_ls',
})

lsp.set_preferences({
    sign_icons = {}
})

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.google_java_format,
        null_ls.builtins.completion.spell,
    },
})

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>lD", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>lR", vim.lsp.buf.references, opts)

    vim.keymap.set("n", "<leader>ldo", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>ldn", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>ldp", vim.diagnostic.goto_prev, opts)

    -- vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)
    -- vim.keymap.set("n", "<leader>vws",  vim.lsp.buf.workspace_symbol, opts)
    -- vim.keymap.set("i", "<C-h>",  vim.lsp.buf.signature_help, opts)
    --
    ---- a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    -- d = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
    -- f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
    -- i = { "<cmd>LspInfo<cr>", "Info" },
    -- l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    -- r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    -- R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
end)

lsp.setup()

-- j = {
--   name = "jc.nvim",
--   i = {
--     "<cmd>lua require('jc.jdtls').organize_imports(true)<cr>",
--     "Organize Imports Smart"
--   },
--   I = {
--     "<cmd>lua require('jc.jdtls').organize_imports(false)<cr>",
--     "Organize Imports"
--   },
--   s = {
--     "<cmd>lua require('jc.jdtls').generate_toString()<cr>",
--     "Gen toString"
--   },
--   h = {
--     "<cmd>lua require('jc.jdtls').generate_hashCodeAndEquals()<cr>",
--     "Gen hashCode and Equals"
--   },
--   A = {
--     "<cmd>lua require('jc.jdtls').generate_accessors()<cr>",
--     "Gen all accessors"
--   },
--   s = {
--     "<cmd>lua require('jc.jdtls').generate_accessor('s')<cr>",
--     "Gen setter",
--   },
--   g = {
--     "<cmd>lua require('jc.jdtls').generate_accessor('g')<cr>",
--     "Gen getter",
--   },
--   a = {
--     "<cmd>lua require('jc.jdtls').generate_accessor('gs')<cr>",
--     "Gen getter/setter",
--   },
--   c = {
--     "<cmd>lua require('jc.jdtls').generate_constructor(nil, nil, {default = false})<cr>",
--     "Gen constructor"
--   },
--   cc = {
--     "<cmd>lua require('jc.jdtls').generate_constructor(nil, nil, {default = true})<cr>",
--     "Gen default constructor"
--   },
--   m = {
--     "<cmd>lua require('jc.jdtls').generate_abstractMethods()<cr>",
--     "Gen abs methods"
--   },
--   e = {
--     "<cmd>lua require('jdtls').extract_variable()<cr>",
--     "Extract variable"
--   },
-- },
--
--  -- "i", "<C-j>i", "<cmd>lua require('jc.jdtls').organize_imports()<cr>", opts)
-- "i", "<C-j>s", "<cmd>lua require('jc.jdtls').generate_accessor('s')<cr>", opts)
-- "i", "<C-j>g", "<cmd>lua require('jc.jdtls').generate_accessor('g')<cr>", opts)
-- "i", "<C-j>a", "<cmd>lua require('jc.jdtls').generate_accessor('sg')<cr>", opts)
-- "i", "<C-j>am", "<cmd>lua require('jc.jdtls').generate_abstractMethods()<cr>", opts)
-- re = { "<Esc><Cmd>lua require('jdtls').extract_variable(true)<cr>" },
-- rm = { "<Esc><Cmd>lua require('jdtls').extract_method(true)<cr>" },
