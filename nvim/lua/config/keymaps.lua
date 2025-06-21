-- Search and scroll being kept in center.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Move block
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Yank & Paste
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to Clipboard" })
vim.keymap.set({ "n", "v" }, "<C-y>", [["+y]], { desc = "Yank to Clipboard" })
vim.keymap.set("x", "<leader>d", [["_d]])
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<leader>pc", [["+p]], { desc = "Paste from Clipboard" })
vim.keymap.set("n", "<leader>pd", [["1p]], { desc = "Paste from Last Deleted" })
vim.keymap.set("n", "<leader>py", [["0p]], { desc = "Paste from Last Yanked" })
vim.keymap.set("n", "<C-p>", [["+p]])

-- Windows
vim.keymap.set("n", "<C-v>", "<cmd>vsp<cr>")
vim.keymap.set("n", "<C-s>", "<cmd>sp<cr>")

-- Misc
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<cr>", { silent = true, desc = "Make executable" })
vim.keymap.set("n", "<leader>-", function()
    vim.cmd("e " .. vim.fn.getcwd())
end, { desc = "Move to CWD" })
vim.keymap.set("n", "<ESC>", "<nop>")

-- Abbreviations
vim.cmd("cnoreabbrev W! w!")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev Wa wa")
vim.cmd("cnoreabbrev wQ wq")
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

-- Open memo / scratch files
local scratch_path = vim.fn.stdpath("data") .. "/scratch/"
vim.api.nvim_create_user_command("Memo", function()
    vim.cmd("e " .. scratch_path .. "memo.md")
end, {})
vim.api.nvim_create_user_command("Scratch", function(opts)
    local extension = opts.fargs[1]
    vim.cmd("e " .. scratch_path .. "scratch." .. extension)
end, {
    nargs = 1,
    complete = function(_, _, _)
        return { "txt", "clj", "lua", "md", "java", "fnl", "lisp" }
    end,
})

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
vim.keymap.set("n", "<leader>bh", bu.popup_select_menu, { desc = "Show Buffer Histories" })
vim.keymap.set("n", "<leader>br", bu.reset_curr_history, { desc = "Reset Current Buffer History" })
vim.keymap.set("n", "<leader>bR", bu.reset_all_histories, { desc = "Reset All Buffer Histories" })
vim.keymap.set("n", "<leader>bd", bu.delete_all_invisible_buffers, { desc = "Delete Other Buffers" })
vim.keymap.set("n", "<leader>bl", "<cmd>b#<cr>", { desc = "Go to Last Buffer" })

-- Test Related
local tu = require("utils.test_utils")
vim.keymap.set("n", "<leader>t", tu.toggle_test, { desc = "Toggle Test File" })

