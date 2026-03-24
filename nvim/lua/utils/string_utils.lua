-- [nfnl] nvim/fnl/utils/string_utils.fnl
local function trim(str)
  return string.gsub(str, "^%s*(.-)%s*$", "%1")
end
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
local function make_literals(str, delimiter)
  local items = {}
  local pattern = ("[^" .. delimiter .. "]+")
  for item in string.gmatch(str, pattern) do
    table.insert(items, make_literal(trim(item)))
  end
  return table.concat(items, (delimiter .. " "))
end
return {["make-literal"] = make_literal, make_literal = make_literal, ["make-literals"] = make_literals, make_literals = make_literals, trim = trim}
