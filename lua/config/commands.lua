-- Abbreviations
local cmd = vim.cmd
cmd("cnoreabbrev W! w!")
cmd("cnoreabbrev Q! q!")
cmd("cnoreabbrev Qall! qall!")
cmd("cnoreabbrev Wq wq")
cmd("cnoreabbrev Wa wa")
cmd("cnoreabbrev wQ wq")
cmd("cnoreabbrev WQ wq")
cmd("cnoreabbrev W w")
cmd("cnoreabbrev Q q")
cmd("cnoreabbrev Qall qall")

local my_funs = require("config/functions")

-- Helper function to get directory of current buffer (not working directory)
local function get_current_dir()
    local current_dir = my_funs.get_current_dir()
    if string.match(current_dir, [[^oil://]]) then
        current_dir = string.sub(current_dir, 7)
    end
    return current_dir
end


-- Write current directory to temp file.
local function update_nvim_cd()
    local current_dir = get_current_dir()
    vim.cmd("!echo " .. current_dir .. " > /tmp/nvim.cd")
end

vim.api.nvim_create_user_command("Ucd", update_nvim_cd, {})
vim.api.nvim_create_autocmd("QuitPre", {
    callback = function(_)
        update_nvim_cd()
    end })

-- Print current buffer's directory
local function print_current_dir()
    vim.print(get_current_dir())
end
vim.api.nvim_create_user_command("Pwd", print_current_dir, {})

-- Cd to current buffer's directory
local function cd_to_current_dir()
    local current_dir = get_current_dir()
    vim.cmd({ cmd = "cd", args = { current_dir }})
end
vim.api.nvim_create_user_command("Cd", cd_to_current_dir, {})

