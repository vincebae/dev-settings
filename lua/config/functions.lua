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

local open_dir = function(directory)
    vim.cmd("Oil " .. directory)
end

local get_file_path = function()
	return vim.fn.expand("%:p")
end

local split_dir_and_file = function(path)
	return string.match(path, [[^(.*/)([^\]+%.%a+)$]])
end

local get_new_path = function(path, orig_pattern, sub_pattern)
	local pattern_found = string.find(path, orig_pattern)
	if pattern_found == nil then
		vim.cmd([[echom "Invalid location"]])
		return nil
	end
	return string.gsub(path, orig_pattern, sub_pattern)
end

M.get_current_dir = function()
	return vim.fn.expand("%:p:h")
end

M.open_dir_by_pattern = function(orig_pattern, sub_pattern)
	local path = M.get_current_dir()
	local new_path = get_new_path(path, orig_pattern, sub_pattern)
	if new_path ~= nil then
		open_dir(new_path)
        return true
	end
    return false
end

M.open_file_by_pattern = function(orig_pattern, sub_pattern)
	local path = get_file_path()
	local new_path = get_new_path(path, orig_pattern, sub_pattern)
	if new_path ~= nil then
		local new_dir, new_file = split_dir_and_file(new_path)
		change_dir(new_dir)
		vim.cmd("e " .. new_file)
        return true
	end
    return false
end

M.cd_to_dir = function()
	local dir = vim.fn.input("Dir > ")
	if dir ~= nil and dir ~= "" then
		open_dir(dir)
	end
end

return M
