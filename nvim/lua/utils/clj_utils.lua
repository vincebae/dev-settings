local my = require("utils.my_utils")
local pu = require("utils.path_utils")
local ts_utils = require("nvim-treesitter.ts_utils")

local function get_namespace()
    local path = pu.relative_path()
    vim.print("path: " .. path)
    local str = string.match(path, [[src/(.*)[.]clj]])
    if str == nil then
        str = string.match(path, [[test/(.*)[.]clj]])
    end
    vim.print("str: " .. (str or "nil"))
    if str == nil then
        return ""
    end

    str = string.gsub(str, "/", ".")
    str = string.gsub(str, "_", "-")
    vim.print("str: " .. str)
    return str
end

local function get_test_namespace()
    local name = get_namespace()
    if my.ends_with(name, "-test") then
        return name
    else
        return name .. "-test"
    end
end

return {
    get_namespace = get_namespace,
    get_test_namespace = get_test_namespace,
}
