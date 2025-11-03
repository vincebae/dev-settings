-- [nfnl] nvim/fnl/utils/test_utils.fnl
local path_utils = require("utils.path_utils")
local popup_utils = require("utils.popup_utils")
local TOGGLE_TEST_OPTS = {java = {["main-dir-pattern"] = "/src/main/", ["test-dir-pattern"] = "/src/test/", ["file-extension"] = "java", ["test-file-suffix"] = "Test"}, clojure = {["main-dir-pattern"] = "/src/", ["test-dir-pattern"] = "/test/", ["file-extension"] = "clj", ["test-file-suffix"] = "_test"}}
local project_type = nil
local function popup_create_menu(path, dir_3f)
  local function on_submit_fn(item)
    local _1_ = item.id
    if (_1_ == "1") then
      if dir_3f then
        path_utils["create-directories"](path)
      else
        path_utils.touch(path)
      end
      return vim.cmd(("e " .. path))
    elseif (_1_ == "2") then
      local parent_path = path_utils.parent(path)
      path_utils["create-directories"](parent_path)
      return vim.cmd(("e " .. parent_path))
    else
      return nil
    end
  end
  local title = (path_utils.filename(path) .. " doesn't exist.")
  local menuitems = {{"Create the file", {id = "1"}}, {"Open parent (create if necessary)", {id = "2"}}, {"Do nothing", {id = "3"}}}
  local callbacks = {on_submit = on_submit_fn}
  return popup_utils.popup_menu(title, menuitems, callbacks)
end
local function popup_project_type_menu(callback_fn)
  local function on_submit_fn(item)
    project_type = item.text
    return callback_fn()
  end
  local title = "Choose project type:"
  local menuitems
  do
    local tbl_21_ = {}
    local i_22_ = 0
    for k_14_auto, __15_auto in pairs(TOGGLE_TEST_OPTS) do
      local val_23_ = k_14_auto
      if (nil ~= val_23_) then
        i_22_ = (i_22_ + 1)
        tbl_21_[i_22_] = val_23_
      else
      end
    end
    menuitems = tbl_21_
  end
  local callbacks = {on_submit = on_submit_fn}
  return popup_utils.popup_menu(title, menuitems, callbacks)
end
local function open_path(path, _3fopts)
  if path then
    local opts = (_3fopts or {})
    if path_utils["exists?"](path) then
      return vim.cmd(("e " .. path))
    elseif opts["prompt-if-not-exist"] then
      return popup_create_menu(path, opts["dir?"])
    else
      return nil
    end
  else
    return nil
  end
end
local function get_toggle_dir_path(path, opts)
  if string.find(path, opts["main-dir-pattern"]) then
    return string.gsub(path, opts["main-dir-pattern"], opts["test-dir-pattern"])
  elseif string.find(path, opts["test-dir-pattern"]) then
    return string.gsub(path, opts["test-dir-pattern"], opts["main-dir-pattern"])
  else
    return nil
  end
end
local function get_toggle_file_path(path, opts)
  local main_file_pattern = string.format("%s(.+)[.]%s$", opts["main-dir-pattern"], opts["file-extension"])
  local test_file_pattern = string.format("%s(.+)%s[.]%s$", opts["test-dir-pattern"], opts["test-file-suffix"], opts["file-extension"])
  if string.find(path, main_file_pattern) then
    local test_file_replace_pattern = string.format("%s%%1%s.%s", opts["test-dir-pattern"], opts["test-file-suffix"], opts["file-extension"])
    return string.gsub(path, main_file_pattern, test_file_replace_pattern)
  elseif string.find(path, test_file_pattern) then
    local main_file_replace_pattern = string.format("%s%%1.%s", opts["main-dir-pattern"], opts["file-extension"])
    return string.gsub(path, test_file_pattern, main_file_replace_pattern)
  else
    return nil
  end
end
local function get_toggle_path(path, dir_3f, opts)
  if dir_3f then
    return get_toggle_dir_path(path, opts)
  else
    return get_toggle_file_path(path, opts)
  end
end
local function get_toggle_test_opts()
  local or_10_ = TOGGLE_TEST_OPTS[project_type]
  if not or_10_ then
    local filetype = vim.bo.filetype
    local opts = TOGGLE_TEST_OPTS[filetype]
    if opts then
      project_type = filetype
      or_10_ = opts
    else
      or_10_ = nil
    end
  end
  return or_10_
end
local function toggle_test()
  local opts = get_toggle_test_opts()
  if (opts == nil) then
    return popup_project_type_menu(toggle_test)
  else
    local path = path_utils["get-buffer-path"]()
    local dir_3f = path_utils["dir?"](path)
    local toggle_path = get_toggle_path(path, dir_3f, opts)
    return open_path(toggle_path, {["prompt-if-not-exist"] = true, ["dir?"] = dir_3f})
  end
end
return {["toggle-test"] = toggle_test, toggle_test = toggle_test}
