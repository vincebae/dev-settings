-- [nfnl] nvim/fnl/utils/path_utils.fnl
local pp = require("plenary.path")
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
local function exists_3f(path)
  return pp:new(path):exists()
end
local function dir_3f(path)
  return pp:new(path):is_dir()
end
local function parent(path)
  return pp:new(path):parent():absolute()
end
local function relative_path(_3fpath, _3fcwd)
  local path = (_3fpath or get_buffer_path())
  local cwd = (_3fcwd or vim.fn.getcwd())
  return pp:new(path):make_relative(cwd)
end
local function create_directories(path)
  return pp:new(path):mkdir({parents = true, exists_ok = true})
end
local function touch(path)
  local plenary_path = pp:new(path)
  if not plenary_path:exists() then
    plenary_path:parent():mkdir({parents = true, exists_ok = true})
    return plenary_path:touch()
  else
    return nil
  end
end
return {["remove-oil-prefix"] = remove_oil_prefix, remove_oil_prefix = remove_oil_prefix, ["get-buffer-path"] = get_buffer_path, get_buffer_path = get_buffer_path, ["get-buffer-dir-path"] = get_buffer_dir_path, get_buffer_dir_path = get_buffer_dir_path, ["get-buffer-filename"] = get_buffer_filename, get_buffer_filename = get_buffer_filename, filename = filename, ["oil-filename"] = oil_filename, oil_filename = oil_filename, ["exists?"] = exists_3f, exists = exists_3f, ["dir?"] = dir_3f, is_dir = dir_3f, parent = parent, ["relative-path"] = relative_path, relative_path = relative_path, ["create-directories"] = create_directories, create_directories = create_directories, touch = touch}
