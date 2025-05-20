local M = { a = 1}

M.starts_with = function(str, prefix) 
    return #str >= #prefix and string.sub(str, 1, #prefix) == prefix
end

M.ends_with = function(str, suffix)
    return #str >= #suffix and string.sub(str, -#suffix) == suffix
end

return M
