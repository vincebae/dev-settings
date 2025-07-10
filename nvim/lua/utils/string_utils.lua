-- [nfnl] nvim/fnl/utils/string_utils.fnl
local function make_literal(str)
  local escaped
  do
    local result = ""
    for c in string.gmatch(str, ".") do
      if ((c == "\\") or (c == "\"")) then
        result = (result .. "\\" .. c)
      elseif (c == "\n") then
        result = (result .. "\\n")
      else
        result = (result .. c)
      end
    end
    escaped = result
  end
  return ("\"" .. escaped .. "\"")
end
return {["make-literal"] = make_literal, make_literal = make_literal}
