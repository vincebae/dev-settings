-- [nfnl] fnl/hello.fnl
local function greet()
  return vim.print("Hello, World!")
end
local str = "Hello, World!"
string.upper(str)
return {greet = greet}
