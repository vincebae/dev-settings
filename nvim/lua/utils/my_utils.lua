local M = { a = 1}

M.starts_with = function(str, prefix) 
    return #str >= #prefix and string.sub(str, 1, #prefix) == prefix
end

M.ends_with = function(str, suffix)
    return #str >= #suffix and string.sub(str, -#suffix) == suffix
end

M.make_literal = function(str, opts)
    local result = ""
    for c in string.gmatch(str, ".") do
        if c == [[\]] or c == [["]] then
            result = result .. [[\]]
        end
        result = result .. c
    end

    opts = opts or {}
    if opts.newline then
        result = result .. "\\n"
    end
    return [["]] .. result .. [["]]
end

return M
