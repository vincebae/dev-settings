local my = require("utils.my_utils")
local pu = require("utils.path_utils")

local function get_namespace()
    local path = pu.relative_path()
    local str = string.match(path, [[src/(.*)[.]clj]])
    if str == nil then
        str = string.match(path, [[test/(.*)[.]clj]])
    end
    if str == nil then
        return ""
    end

    str = string.gsub(str, "/", ".")
    str = string.gsub(str, "_", "-")
    return str
end

local function get_test_namespace()
    local name = get_namespace()
    if my.ends_with(name, "-test") then
        return name
    else
        return name .. "-test"
    end
end

local function eval_buf_and_command(command)
    local filename = pu.relative_path()
    local load_file_command = '(load-file "' .. filename .. '")'
    vim.cmd("ConjureEval (do " .. load_file_command .. " " .. command .. ")")
end

local function reload_namespace()
    local namespace = get_namespace()
    local command = "(require '" .. namespace .. " :reload-all)"
    eval_buf_and_command(command)
end

local function into_namespace()
    local namespace = get_namespace()
    local command = "(in-ns '" .. namespace .. ")"
    eval_buf_and_command(command)
end

local function test_namespace()
    local namespace = get_namespace()
    local command = "(clojure.test/run-tests '" .. namespace .. ")"
    eval_buf_and_command(command)
end

local function nrepl_server_command()
    return "clj -Sdeps '{:deps {nrepl/nrepl {:mvn/version \"1.3.1\"}}}' -M -m nrepl.cmdline"
end

local function start_nrepl_server()
    require("toggleterm").exec(
        nrepl_server_command(),
        11, -- num
        20, -- size
        ".", -- dir
        "horizontal",
        "nREPL-Server",
        true, -- go_back
        false -- open
    )
    vim.notify("Starting Clojure nREPL server starting...")
end

local function doc_str()
    local expr = vim.fn.input("Symbol > ")
    if expr and expr ~= "" then
        vim.cmd("ConjureEval (clojure.repl/doc " .. expr .. ")")
    end
end

return {
    get_namespace = get_namespace,
    get_test_namespace = get_test_namespace,
    reload_namespace = reload_namespace,
    into_namespace = into_namespace,
    test_namespace = test_namespace,
    nrepl_server_command = nrepl_server_command,
    start_nrepl_server = start_nrepl_server,
    doc_str = doc_str,
}
