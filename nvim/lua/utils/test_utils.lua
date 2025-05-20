local path_utils = require("utils.path_utils")
local popup_utils = require("utils.popup_utils")

local TOGGLE_TEST_OPTS = {
    ["java"] = {
        main_dir_pattern = "/src/main/",
        test_dir_pattern = "/src/test/",
        file_extension = "java",
        test_file_suffix = "Test",
    },
    ["clojure"] = {
        main_dir_pattern = "/src/",
        test_dir_pattern = "/test/",
        file_extension = "clj",
        test_file_suffix = "_test",
    },
}

local project_type = nil

local function popup_create_menu(path, is_dir)
    local title = path_utils.filename(path) .. " doesn't exist."
    local menuitems = {
        { "Create", { id = "1" } },
        { "Open parent", { id = "2" } },
        { "Do nothing", { id = "3" } },
    }
    local callbacks = {
        on_submit = function(item)
            if item.id == "1" then
                if is_dir then
                    path_utils.create_directories(path)
                else
                    path_utils.touch(path)
                end
                open_path(path)
            elseif item.id == "2" then
                local parentPath = path_utils.parent(path)
                open_path(parentPath, { prompt_if_not_exist = true, is_dir = true })
            end
        end,
    }
    popup_utils.popup_menu(title, menuitems, callbacks)
end

local function popup_project_type_menu(callback_fn)
    local title = "Choose project type:"
    local menuitems = {}
    local index = 1
    for k, _ in pairs(TOGGLE_TEST_OPTS) do
        table.insert(menuitems, index, k)
        index = index + 1
    end

    local callbacks = {
        on_submit = function(item)
            project_type = item.text
            callback_fn()
        end,
    }
    popup_utils.popup_menu(title, menuitems, callbacks)
end

local open_path = function(path, opts)
    if path == nil then
        return
    end

    opts = opts or {}
    if path_utils.exists(path) then
        vim.cmd("e " .. path)
    elseif opts.prompt_if_not_exist then
        popup_create_menu(path, opts.is_dir)
    end
end

local function get_toggle_dir_path(path, opts)
    if string.find(path, opts.main_dir_pattern) ~= nil then
        return string.gsub(path, opts.main_dir_pattern, opts.test_dir_pattern)
    elseif string.find(path, opts.test_dir_pattern) ~= nil then
        return string.gsub(path, opts.test_dir_pattern, opts.main_dir_pattern)
    else
        return nil
    end
end

local function get_toggle_file_path(path, opts)
    local main_file_pattern = string.format("%s(.+)[.]%s$", opts.main_dir_pattern, opts.file_extension)
    local test_file_pattern =
        string.format("%s(.+)%s[.]%s$", opts.test_dir_pattern, opts.test_file_suffix, opts.file_extension)
    if string.find(path, main_file_pattern) ~= nil then
        local test_file_replace_pattern =
            string.format("%s%%1%s.%s", opts.test_dir_pattern, opts.test_file_suffix, opts.file_extension)
        return string.gsub(path, main_file_pattern, test_file_replace_pattern)
    elseif string.find(path, test_file_pattern) ~= nil then
        local main_file_replace_pattern = string.format("%s%%1.%s", opts.main_dir_pattern, opts.file_extension)
        return string.gsub(path, test_file_pattern, main_file_replace_pattern)
    else
        return nil
    end
end

local function get_toggle_path(path, is_dir, opts)
    if is_dir then
        return get_toggle_dir_path(path, opts)
    else
        return get_toggle_file_path(path, opts)
    end
end

local function get_toggle_test_opts()
    local filetype = vim.bo.filetype
    for k, v in pairs(TOGGLE_TEST_OPTS) do
        if k == filetype then
            project_type = filetype
            return v
        end
    end

    if project_type then
        return TOGGLE_TEST_OPTS[project_type]
    else
        return nil
    end
end

local function toggle_test()
    local opts = get_toggle_test_opts()
    if opts == nil then
        popup_project_type_menu(toggle_test)
        return
    end

    local path = path_utils.get_buffer_path()
    local is_dir = path_utils.is_dir(path)
    local toggle_path = get_toggle_path(path, is_dir, opts)
    open_path(toggle_path, { prompt_if_not_exist = true, is_dir = is_dir })
end

return {
    toggle_test = toggle_test,
}
