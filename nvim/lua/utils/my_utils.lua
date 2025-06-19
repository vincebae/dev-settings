-- [nfnl] nvim/fnl/utils/my_utils.fnl
local function zero_3f(n)
  return (n == 0)
end
local function pos_3f(n)
  return (n > 0)
end
local function neg_3f(n)
  return (n < 0)
end
local function even_3f(n)
  return ((n % 2) == 0)
end
local function odd_3f(n)
  return ((n % 2) == 1)
end
local function inc(n)
  return (n + 1)
end
local function dec(n)
  return (n - 1)
end
local function empty_3f(coll)
  return zero_3f(#coll)
end
local function first(coll)
  return coll[1]
end
local function last(coll)
  return coll[#coll]
end
local function has_value_3f(coll, target)
  local found_3f = false
  for _, value in pairs(coll) do
    if found_3f then break end
    found_3f = (value == target)
  end
  return found_3f
end
local function partition(n, coll)
  assert(pos_3f(n), "n must be positive")
  local result = {}
  local curr = {}
  for _, x in pairs(coll) do
    table.insert(curr, x)
    if (n == #curr) then
      table.insert(result, curr)
      curr = {}
    else
    end
  end
  return result
end
local function starts_with(str, prefix)
  local str_len = #str
  local prefix_len = #prefix
  return ((str_len >= prefix_len) and (string.sub(str, 1, prefix_len) == prefix))
end
local function ends_with(str, suffix)
  local str_len = #str
  local suffix_len = #suffix
  return ((str_len >= suffix_len) and (string.sub(str, ( - suffix_len)) == suffix))
end
local str_need_escape = {"\\", "\""}
local function make_literal(str)
  local escaped
  do
    local result = ""
    for c in string.gmatch(str, ".") do
      if has_value_3f(str_need_escape, c) then
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
return {["zero?"] = zero_3f, is_zero = zero_3f, ["pos?"] = pos_3f, is_pos = pos_3f, ["neg?"] = neg_3f, is_neg = neg_3f, ["even?"] = even_3f, is_even = even_3f, ["odd?"] = odd_3f, is_odd = odd_3f, inc = inc, dec = dec, ["empty?"] = empty_3f, is_empty = empty_3f, first = first, last = last, ["has-value?"] = has_value_3f, has_value = has_value_3f, partition = partition, ["starts-with"] = starts_with, starts_with = starts_with, ["ends-with"] = ends_with, ends_with = ends_with, ["make-literal"] = make_literal, make_literal = make_literal}
