local my = require("utils.my_utils")
local Path = require("plenary.path")

local remove_oil_prefix = function(path)
    if my.starts_with(path, "oil://") then
        return string.sub(path, 7)
    else
        return path
    end
end

local get_buffer_path = function()
    return remove_oil_prefix(vim.fn.expand("%:p"))
end

local get_buffer_dir_path = function()
    return remove_oil_prefix(vim.fn.expand("%:p:h"))
end

local get_buffer_filename = function()
    return vim.fn.expand("%:t")
end

local filename = function(path)
    local split_path = vim.fn.split(path, "/")
    return split_path[#split_path]
end

local oil_filename = function()
    local line = vim.api.nvim_get_current_line()
    local name = string.match(line, [[.*  (.*)]])
    if name == nil then
        return ""
    end
    return get_buffer_dir_path() .. "/" .. name
end

local exists = function(path)
    return Path:new(path):exists()
end

local is_dir = function(path)
    return Path:new(path):is_dir()
end

local parent = function(path)
    return Path:new(path):parent():absolute()
end

-- Create directories recursively for the given path.
local create_directories = function(path)
    Path:new(path):mkdir({ parents = true, exists_ok = true })
end

-- Touch the file for the given path only when the file doesn't exist.
-- Also create parent directories if necessary
local touch = function(path)
    local plenaryPath = Path:new(path)
    if plenaryPath:exists() then
        return
    end

    plenaryPath:parent():mkdir({ parents = true, exists_ok = true })
    plenaryPath:touch()
end

local relative_path = function(path, cwd)
    cwd = cwd or vim.fn.getcwd()
    return Path:new(path):make_relative(cwd)
end

return {
    get_buffer_path = get_buffer_path,
    get_buffer_dir_path = get_buffer_dir_path,
    get_buffer_filename = get_buffer_filename,
    filename = filename,
    oil_filename = oil_filename,
    exists = exists,
    is_dir = is_dir,
    parent = parent,
    create_directories = create_directories,
    touch = touch,
    relative_path = relative_path,
}
