local pu = require("utils.path_utils")
local toggleterm = require("toggleterm")
local ts_utils = require("nvim-treesitter.ts_utils")

local function get_package_name()
    local path = pu.get_buffer_dir_path()
    local extracted = string.match(path, [[.*/src/%a+/java/(.*)]])
    if extracted ~= nil then
        return string.gsub(extracted, "/", ".")
    else
        return ""
    end
end

local function get_class_name()
    local filename = pu.get_buffer_filename()
    return string.gsub(filename, ".java$", "")
end

local function get_test_class_name()
    local name = get_class_name()
    if string.sub(name, -4) == "Test" then
        return name
    else
        return name .. "Test"
    end
end

local function get_current_method_name()
    local node = ts_utils.get_node_at_cursor(0, true)
    while node do
        if node:type() == "method_declaration" then
            for child, _ in node:iter_children() do
                if child:type() == "identifier" then
                    return vim.treesitter.get_node_text(child, vim.fn.bufnr())
                end
            end
        end
        node = node:parent()
    end
    return ""
end

-- Debug Test Runner
local function run_test(test_name, debug)
    local test_cmd = "./gradlew test --rerun"
    if test_name ~= nil and test_name ~= "" then
        test_cmd = test_cmd .. " --tests " .. test_name .. " --rerun"
    end
    if debug then
        test_cmd = test_cmd .. " --debug-jvm"
    end
    toggleterm.exec(test_cmd, 1, 20, "horizontal")
end

local function run_test_all(debug)
    run_test("", debug)
end

local function run_test_class(debug)
    run_test(get_test_class_name(), debug)
end

local function run_test_method(debug)
    local method_name = vim.fn.input("Method:", get_current_method_name())
    if method_name ~= "" then
        local test_name = get_package_name() .. "." .. get_test_class_name() .. "." .. method_name
        run_test(test_name, debug)
    end
end

return {
    get_package_name = get_package_name,
    get_class_name = get_class_name,
    get_test_class_name = get_test_class_name,
    run_test_all = run_test_all,
    run_test_class = run_test_class,
    run_test_method = run_test_method,
}
