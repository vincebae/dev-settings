local M = {}

-- Cheat sheet
M.open_cheatsheet = function(command, lang)
	local local_lang = lang
	if local_lang == "" then
		local_lang = vim.fn.input("Lang > ")
	end
	local query = vim.fn.input("Query > "):gsub("%s+", "+")
	local tmp_file = "/tmp/cht.sh.output"
	vim.cmd("! cht.sh " .. local_lang .. "/" .. query .. " | ansifilter > " .. tmp_file)
	vim.cmd(command .. " " .. tmp_file)
	vim.opt_local.readonly = true
end

local change_dir = function(directory)
	vim.cmd("cd " .. directory)
end

local open_tree = function()
	vim.cmd("e .")
end

local get_file_path = function()
	return vim.fn.expand("%:p")
end

local get_current_dir = function()
	return vim.fn.expand("%:p:h")
end

local split_dir_and_file = function(path)
	return string.match(path, [[^(.*/)(%a+%.java)$]])
end

local get_new_path = function(path, orig_pattern, sub_pattern)
	local pattern_found = string.find(path, orig_pattern)
	if pattern_found == nil then
		vim.cmd([[echom "Invalid location"]])
		return nil
	end
	return string.gsub(path, orig_pattern, sub_pattern)
end

local open_tree_by_pattern = function(orig_pattern, sub_pattern)
	local path = get_current_dir()
	local new_path = get_new_path(path, orig_pattern, sub_pattern)
	if new_path ~= nil then
		change_dir(new_path)
		open_tree()
	end
end

local open_file_by_pattern = function(orig_pattern, sub_pattern)
	local path = get_file_path()
	local new_path = get_new_path(path, orig_pattern, sub_pattern)
	if new_path ~= nil then
		local new_dir, new_file = split_dir_and_file(new_path)
		change_dir(new_dir)
		vim.cmd("e " .. new_file)
	end
end

M.open_test_file = function()
	local main_file_pattern = [[/src/main/(.*/%a+).java$]]
	local test_file_pattern = [[/src/test/%1Test.java]]
	open_file_by_pattern(main_file_pattern, test_file_pattern)
end

M.open_main_file = function()
	local test_file_pattern = [[/src/test/(.*/%a+)Test.java$]]
	local main_file_pattern = [[/src/main/%1.java]]
	open_file_by_pattern(test_file_pattern, main_file_pattern)
end

M.cd_to_test_dir = function()
	local java_dir_pattern = [[/src/main/]]
	local test_dir_pattern = [[/src/test/]]
	open_tree_by_pattern(java_dir_pattern, test_dir_pattern)
end

M.cd_to_main_dir = function()
	local test_dir_pattern = [[/src/test/]]
	local java_dir_pattern = [[/src/main/]]
	open_tree_by_pattern(test_dir_pattern, java_dir_pattern)
end

M.cd_to_top_dir = function()
	local dir_pattern = [[/src/[mt][ae][is][nt]/.*$]]
	local new_dir_pattern = ""
	open_tree_by_pattern(dir_pattern, new_dir_pattern)
end

M.cd_to_curr_dir = function()
	change_dir(get_current_dir())
	open_tree()
end

M.cd_to_dir = function()
	local dir = vim.fn.input("Dir > ")
	if dir ~= nil and dir ~= "" then
		change_dir(dir)
		open_tree()
	end
end

return M
