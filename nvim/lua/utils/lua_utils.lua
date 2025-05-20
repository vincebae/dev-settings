local my = require("utils.my_utils")
local pu = require("utils.path_utils")

local function get_package_name()
    local path = pu.get_buffer_path()
    local extracted = string.match(path, [[.*/lua/(.*).lua$]])
    if extracted ~= nil then
        return string.gsub(extracted, "/", ".")
    else
        return ""
    end
end

local function unload_package()
    local package_name = get_package_name()
    if package_name ~= "" then
        package.loaded[package_name] = nil
    end
end

return {
    get_package_name = get_package_name,
    unload_package = unload_package,
}
