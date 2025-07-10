-- [nfnl] nvim/fnl/utils/clj_utils.fnl
local pu = require("utils.path_utils")
local function get_namespace()
  local function path__3enamespace(path)
    return string.gsub(string.gsub(path, "/", "."), "_", "-")
  end
  local path = pu.relative_path()
  local src_path = string.match(path, "src/(.*)[.]clj")
  local test_path = string.match(path, "test/(.*)[.]clj")
  if src_path then
    return path__3enamespace(src_path)
  elseif test_path then
    return path__3enamespace(test_path)
  else
    return ""
  end
end
local function get_test_namespace()
  local test_namespace_suffix = "-test"
  local name = get_namespace()
  local x_23_auto = name
  local _2_
  do
    local s_21_auto = test_namespace_suffix
    _2_ = (string.sub(name, ( - #s_21_auto)) == s_21_auto)
  end
  if not _2_ then
    return (x_23_auto .. test_namespace_suffix)
  else
    return x_23_auto
  end
end
local function eval_buf_and_command(command)
  local filename = pu["relative-path"]()
  local load_file_command = ("(load-file \"" .. filename .. "\")")
  local eval_command = ("ConjureEval (do " .. load_file_command .. " " .. command .. ")")
  return vim.cmd(eval_command)
end
local function reload_namespace()
  local namespace = get_namespace()
  local command = ("(require '" .. namespace .. " :reload-all)")
  return eval_buf_and_command(command)
end
local function into_namespace()
  local namespace = get_namespace()
  local command = ("(in-ns '" .. namespace .. ")")
  return eval_buf_and_command(command)
end
local function test_namespace()
  local namespace = get_namespace()
  local command = ("(clojure.test/run-tests '" .. namespace .. ")")
  return eval_buf_and_command(command)
end
local function nrepl_server_command()
  return "clj -Sdeps '{:deps {nrepl/nrepl {:mvn/version \"1.3.1\"}}}' -M -m nrepl.cmdline"
end
local function start_nrepl_server()
  local toggleterm = require("toggleterm")
  toggleterm.exec(nrepl_server_command(), 20, ".", "horizontal", "nREPL-Server", true, false)
  return vim.notify("Starting Clojure nREPL server starting...")
end
local function doc_str()
  local expr = vim.fn.input("Symbol > ")
  local _4_
  do
    local s_19_auto = expr
    _4_ = (s_19_auto and (s_19_auto ~= ""))
  end
  if _4_ then
    return vim.cmd(("ConjureEval (clojure.repl/doc " .. expr .. ")"))
  else
    return nil
  end
end
return {["get-namespace"] = get_namespace, get_namespace = get_namespace, ["get-test-namespace"] = get_test_namespace, get_test_namespace = get_test_namespace, ["eval-buf-and-command"] = eval_buf_and_command, eval_buf_and_command = eval_buf_and_command, ["reload-namespace"] = reload_namespace, reload_namespace = reload_namespace, ["into-namespace"] = into_namespace, into_namespace = into_namespace, ["test-namespace"] = test_namespace, test_namespace = test_namespace, ["nrepl-server-command"] = nrepl_server_command, nrepl_server_command = nrepl_server_command, ["start-nrepl-server"] = start_nrepl_server, start_nrepl_server = start_nrepl_server, ["doc-str"] = doc_str, doc_str = doc_str}
