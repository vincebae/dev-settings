-- [nfnl] nvim/fnl/utils/lua_utils.fnl
local pu = require("utils.path_utils")
local function get_package_name()
  local function helper(path, file_type)
    local file_pattern
    if (file_type == "lua") then
      file_pattern = ".*/lua/(.*).lua$"
    elseif (file_type == "fnl") then
      file_pattern = ".*/fnl/(.*).fnl$"
    else
      file_pattern = nil
    end
    local extracted = string.match(path, file_pattern)
    if extracted then
      return string.gsub(extracted, "/", ".")
    else
      return nil
    end
  end
  local path = pu["get-buffer-path"]()
  return (helper(path, "lua") or helper(path, "fnl") or "")
end
local function unload_package()
  local package_name = get_package_name()
  if (package_name ~= "") then
    package.loaded[package_name] = nil
    return nil
  else
    return nil
  end
end
return {get_package_name = get_package_name, unload_package = unload_package}
