-- [nfnl] nvim/fnl/utils/java_utils.fnl
local pu = require("utils.path_utils")
local su = require("utils.string_utils")
local toggleterm = require("toggleterm")
local ts_utils = require("nvim-treesitter.ts_utils")
local function get_package_name()
  local _1_
  do
    local tmp_3_ = pu["get-buffer-dir-path"]()
    if (nil ~= tmp_3_) then
      local tmp_3_0 = string.match(tmp_3_, ".*/src/%a+/java/(.*)")
      if (nil ~= tmp_3_0) then
        _1_ = string.gsub(tmp_3_0, "/", ".")
      else
        _1_ = nil
      end
    else
      _1_ = nil
    end
  end
  return (_1_ or "")
end
local function get_class_name()
  return string.gsub(pu["get-buffer-filename"](), ".java$", "")
end
local function get_test_class_name()
  local name = get_class_name()
  local _5_
  do
    local s_21_auto = "Test"
    _5_ = (string.sub(name, ( - #s_21_auto)) == s_21_auto)
  end
  if _5_ then
    return name
  else
    return (name .. "Test")
  end
end
local function get_current_method_name()
  local function get_method_identifier(node)
    if (node:type() == "method_declaration") then
      local identifier = nil
      for child, _ in node:iter_children() do
        if identifier then break end
        if (child:type() == "identifier") then
          identifier = vim.treesitter.get_node_text(child, vim.fn.bufnr())
        else
          identifier = nil
        end
      end
      return identifier
    else
      return nil
    end
  end
  local name = nil
  local node = ts_utils.get_node_at_cursor(0, true)
  while ((name == nil) and node) do
    name = get_method_identifier(node)
    node = node:parent()
  end
  return (name or "")
end
local function run_test(test_name, opts)
  local function send_to_terminal(cmd)
    return toggleterm.exec(cmd, 1, 20, ".", "horizontal")
  end
  local function send_to_slime(cmd)
    return vim.cmd(("SlimeSend0 " .. su.make_literal((cmd .. "\n"))))
  end
  local x_23_auto
  do
    local x_23_auto0
    do
      local x_23_auto1
      do
        local x_23_auto2 = "./gradlew test --rerun"
        local _9_
        do
          local s_19_auto = test_name
          _9_ = (s_19_auto and (s_19_auto ~= ""))
        end
        if _9_ then
          x_23_auto1 = (x_23_auto2 .. " --tests " .. test_name)
        else
          x_23_auto1 = x_23_auto2
        end
      end
      if opts.debug then
        x_23_auto0 = (x_23_auto1 .. " --debug-jvm")
      else
        x_23_auto0 = x_23_auto1
      end
    end
    if (opts.env == "terminal") then
      x_23_auto = send_to_terminal(x_23_auto0)
    else
      x_23_auto = x_23_auto0
    end
  end
  if (opts.env == "slime") then
    return send_to_slime(x_23_auto)
  else
    return x_23_auto
  end
end
local function run_test_all(opts)
  return run_test("", opts)
end
local function run_test_class(opts)
  return run_test(get_test_class_name(), opts)
end
local function run_test_method(opts)
  local method_name = vim.fn.input("Method:", get_current_method_name())
  local _14_
  do
    local s_19_auto = method_name
    _14_ = (s_19_auto and (s_19_auto ~= ""))
  end
  if _14_ then
    local test_name = (get_package_name() .. "." .. get_test_class_name() .. "." .. method_name)
    return run_test(test_name, opts)
  else
    return nil
  end
end
return {["get-package-name"] = get_package_name, get_package_name = get_package_name, ["get-class-name"] = get_class_name, get_class_name = get_class_name, ["get-test-class-name"] = get_test_class_name, get_test_class_name = get_test_class_name, ["get-current-method-name"] = get_current_method_name, get_current_method_name = get_current_method_name, ["run-test"] = run_test, run_test = run_test, ["run-test-all"] = run_test_all, run_test_all = run_test_all, ["run-test-class"] = run_test_class, run_test_class = run_test_class, ["run-test-method"] = run_test_method, run_test_method = run_test_method}
