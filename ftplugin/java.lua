vim.opt.colorcolumn = "100"
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>lD", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>lR", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>ll", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>ln", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>lp", vim.diagnostic.goto_prev)

local jdtls = require('jdtls')
local setup = require('jdtls.setup')

local mason_path = vim.fn.expand("$HOME/.local/share/nvim/mason")
local jdtls_path = mason_path .. "/bin/jdtls"
local lombok_path = mason_path .. "/packages/ldtls/lombok.jar"

local config = {
    cmd = {
        jdtls_path,
        "--jvm-arg=-javaagent:" .. lombok_path,
    },
    root_dir = setup.find_root({'.git', 'mvnw', 'gradlew'}),
}

jdtls.start_or_attach(config)
