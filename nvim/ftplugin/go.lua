vim.opt.expandtab = false
vim.opt.list = true
vim.opt.listchars = "tab:» ,trail:•"

local pu = require("utils.path_utils")
local su = require("utils.string_utils")

vim.api.nvim_create_user_command("GoRun", function()
    local filename = pu.get_buffer_path()
    local cmd = "go run " .. filename .. "\n"
    vim.cmd("SlimeSend0 " .. su.make_literal(cmd))
end, {})

-- aliases
-- vim.cmd("command! GB GoBuild")
vim.cmd("command! GR GoRun")
-- vim.cmd("command! GT GoTest")
