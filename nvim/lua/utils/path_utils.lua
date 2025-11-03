-- [nfnl] nvim/fnl/utils/path_utils.fnl
local function remove_oil_prefix(path)
  local x_23_auto = path
  local _1_
  do
    local p_20_auto = "oil://"
    _1_ = (string.sub(path, 1, #p_20_auto) == p_20_auto)
  end
  if _1_ then
    return string.sub(x_23_auto, 7)
  else
    return x_23_auto
  end
end
local function get_buffer_path()
  return remove_oil_prefix(vim.fn.expand("%:p"))
end
local function get_buffer_dir_path()
  return remove_oil_prefix(vim.fn.expand("%:p:h"))
end
local function get_buffer_filename()
  return vim.fn.expand("%:t")
end
local function filename(path)
  local len_3_auto = #vim.fn.split(path, "/")
  return vim.fn.split(path, "/")[len_3_auto]
end
local function oil_filename()
  local line = vim.api.nvim_get_current_line()
  local name = string.match(line, ".*  (.*)")
  if name then
    return (get_buffer_dir_path() .. "/" .. name)
  else
    return ""
  end
end
local function regular_file_3f(path)
  return (vim.fn.filereadable(path) == 1)
end
local function dir_3f(path)
  return (vim.fn.isdirectory(path) == 1)
end
local function exists_3f(path)
  return (regular_file_3f(path) or dir_3f(path))
end
local function parent(path)
  return path:match("(.*)/")
end
local function relative_path(_3fpath, _3fcwd)
  local function with_separator(p)
    local len = #p
    local last_char = p:sub(len)
    local x_23_auto = p
    if (last_char ~= "/") then
      return (x_23_auto .. "/")
    else
      return x_23_auto
    end
  end
  local path = (_3fpath or get_buffer_path())
  local path_with_sep = with_separator(path)
  local cwd = (_3fcwd or vim.fn.getcwd())
  local cwd_with_sep = with_separator(cwd)
  if (path_with_sep == cwd_with_sep) then
    return "."
  else
    local _5_
    do
      local p_20_auto = cwd_with_sep
      _5_ = (string.sub(path, 1, #p_20_auto) == p_20_auto)
    end
    if _5_ then
      return path:sub((#cwd_with_sep + 1), -1)
    else
      return path
    end
  end
end
local function create_directories(path)
  return vim.fn.mkdir(path, "p")
end
local function touch(path)
  local function touch_internal()
    create_directories(parent(path))
    local file = io.open(path, "a")
    if file then
      file:close()
      return vim.notify(("File '" .. path .. "' touched."))
    else
      return vim.notify(("Error: Could not touch file '" .. path .. "'."), vim.log.levels.ERROR)
    end
  end
  if not exists_3f(path) then
    return touch_internal(path)
  else
    return vim.notify(("File '" .. path .. "' already exists."), vim.log.levels.WARN)
  end
end
return {["remove-oil-prefix"] = remove_oil_prefix, remove_oil_prefix = remove_oil_prefix, ["get-buffer-path"] = get_buffer_path, get_buffer_path = get_buffer_path, ["get-buffer-dir-path"] = get_buffer_dir_path, get_buffer_dir_path = get_buffer_dir_path, ["get-buffer-filename"] = get_buffer_filename, get_buffer_filename = get_buffer_filename, filename = filename, ["oil-filename"] = oil_filename, oil_filename = oil_filename, ["regular-file?"] = regular_file_3f, is_regular_file = regular_file_3f, ["dir?"] = dir_3f, is_dir = dir_3f, ["exists?"] = exists_3f, exists = exists_3f, parent = parent, ["relative-path"] = relative_path, relative_path = relative_path, ["create-directories"] = create_directories, create_directories = create_directories, touch = touch}
