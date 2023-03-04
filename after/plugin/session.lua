local auto_session = require("auto-session")
local session_lens = require('session-lens')

auto_session.setup {
    log_level = "error",
    auto_session_suppress_dirs = {
        "~/", "~/Projects", "~/Downloads", "/"
    },
}

session_lens.setup({
    path_display = { 'shorten' },
})

require("telescope").load_extension("session-lens")

vim.keymap.set('n', '<leader>ss', "<cmd>SaveSession<cr>", {})
vim.keymap.set('n', '<leader>sr', "<cmd>RestoreSession<cr>", {})
vim.keymap.set('n', '<leader>sd', "<cmd>Autosession delete<cr>", {})
vim.keymap.set('n', '<leader>sf', session_lens.search_session, {})
