local M = {}

-- Cheat sheet
M.open_cheatsheet = function(command, lang)
    return function()
        local local_lang = lang
        if local_lang == "" then
            local_lang = vim.fn.input("Lang > ")
        end
        local query = vim.fn.input("Query > "):gsub("%s+", "+")
        local tmp_file = "/tmp/cht.sh.output"
        vim.cmd("! cht.sh " .. local_lang .. "/" .. query .. " | ansi2txt > " .. tmp_file)
        vim.cmd(command .. " " .. tmp_file)
        vim.opt_local.readonly = true
    end
end

return M
