-- Abbreviations
vim.cmd("cnoreabbrev W! w!")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev Wa wa")
vim.cmd("cnoreabbrev wQ wq")
vim.cmd("cnoreabbrev WQ wq")
vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev Q! q!")
vim.cmd("cnoreabbrev Qa! qa!")
vim.cmd("cnoreabbrev Qall! qall!")
vim.cmd("cnoreabbrev Q q")
vim.cmd("cnoreabbrev Qa qa")
vim.cmd("cnoreabbrev Qall qall")

-- Clear lua package cache on save
vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
        local ft = vim.bo.filetype
        if ft == "lua" then
            require("utils.lua_utils").unload_package()
        end
    end,
})

-- Open memo / todo files
vim.api.nvim_create_user_command("Memo", function()
    vim.cmd("e ~/Documents/org/memo.org")
end, {})
vim.api.nvim_create_user_command("Todo", function()
    vim.cmd("e ~/Documents/org/todo.org")
end, {})

-- Quit nvim with writing current directory to temp file.
local pu = require("utils.path_utils")
local function update_nvim_cd()
    local current_dir = pu.get_buffer_dir_path()
    vim.cmd('silent exec "!echo ' .. current_dir .. ' > /tmp/nvim.cd"')
    vim.print("Curr buffer dir written to /tmp/nvim.cd.\nUse vcd from terminal to cd to the dir.")
    return current_dir
end
vim.api.nvim_create_user_command("Vcd", update_nvim_cd, {})
vim.api.nvim_create_autocmd("QuitPre", {
    callback = function(_)
        update_nvim_cd()
    end,
})

-- Buffer Related
local bu = require("utils.buffer_utils")
local buffer_history_augroup = vim.api.nvim_create_augroup("BUFFER_HISTORY_GROUP", {
    clear = true,
})
vim.api.nvim_create_autocmd("BufEnter", {
    group = buffer_history_augroup,
    callback = bu.on_enter,
})
vim.api.nvim_create_autocmd("BufDelete", {
    group = buffer_history_augroup,
    callback = bu.on_delete,
})

vim.keymap.set("n", "[b", bu.back)
vim.keymap.set("n", "]b", bu.forward)
vim.keymap.set("n", "<leader>bh", bu.popup_select_menu)
vim.keymap.set("n", "<leader>br", bu.reset_curr_history)
vim.keymap.set("n", "<leader>bR", bu.reset_all_histories)
vim.keymap.set("n", "<leader>bd", bu.delete_all_invisible_buffers)

-- Test Related
local tu = require("utils.test_utils")
vim.keymap.set("n", "<leader>t", tu.toggle_test)
