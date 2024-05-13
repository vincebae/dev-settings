vim.opt.colorcolumn = "100"
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Snippets
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

local get_package_name = function()
	local path = vim.fn.expand("%:p:h")
	local extracted = string.match(path, [[.*/src/%a+/scala/(.*)]])
	if extracted ~= nil then
		return string.gsub(extracted, "/", ".")
	else
		return ""
	end
end

local get_class_name = function()
	local filename = vim.fn.expand("%:t")
	return string.gsub(filename, ".scala$", "")
end

ls.add_snippets(nil, {
	scala = {
		s("shebang", {
            t({ "#!/usr/bin/env -S scala-cli shebang -S 3 --bloop-version 1.5.12-sc-1", ""}),
			-- t({ "#!/usr/bin/env amm", "" }),
		}),
		s("package", {
			t("package "),
			f(get_package_name, {}),
			t({ ";", "" }),
		}),
	},
})

-- Navigation
local my_funs = require("config/functions")

local toggle_test_file = function()
	local path = vim.fn.expand("%:p")
	local src_file_pattern = [[/src/main/(.*/[%a%d]+).scala$]]
	local test_file_pattern = [[/src/test/(.*/[%a%d]+)Test.scala$]]
	if string.find(path, src_file_pattern) ~= nil then
		local test_file_replace_pattern = [[/src/test/%1Test.scala]]
		my_funs.open_file_by_pattern(src_file_pattern, test_file_replace_pattern)
	elseif string.find(path, test_file_pattern) ~= nil then
		local src_file_replace_pattern = [[/src/main/%1.scala]]
		my_funs.open_file_by_pattern(test_file_pattern, src_file_replace_pattern)
	end
end

local toggle_test_dir = function()
	local path = vim.fn.expand("%:p")
	local src_dir_pattern = [[/src/main/]]
	local test_dir_pattern = [[/src/test/]]
	if string.find(path, src_dir_pattern) ~= nil then
		my_funs.open_dir_by_pattern(src_dir_pattern, test_dir_pattern)
	elseif string.find(path, test_dir_pattern) ~= nil then
		my_funs.open_dir_by_pattern(test_dir_pattern, src_dir_pattern)
	end
end

local cd_to_top_dir = function()
	local dir_pattern = [[/src/[mt][ae][is][nt]/.*$]]
	local new_dir_pattern = ""
	my_funs.open_dir_by_pattern(dir_pattern, new_dir_pattern)
end

local keymap = vim.keymap
keymap.set("n", "<leader>nP", function()
	cd_to_top_dir()
end)
keymap.set("n", "<leader>nT", function()
	toggle_test_dir()
end)
keymap.set("n", "<leader>nt", function()
	toggle_test_file()
end)
keymap.set("n", "<localleader>P", function()
	cd_to_top_dir()
end)
keymap.set("n", "<localleader>T", function()
	toggle_test_dir()
end)
keymap.set("n", "<localleader>t", function()
	toggle_test_file()
end)

-- Scala specific which-key mapping
local which_key = require("which-key")
local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local ll_opts = {
	mode = "n", -- NORMAL mode
	prefix = "<localleader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	n = {
		name = "Navigation",
		P = { "Open top dir" },
		T = { "Toggle test dir" },
		t = { "Toggle test file" },
	},
}

local ll_mappings = {
	-- Navigations
	P = { "Open top dir" },
	T = { "Toggle test dir" },
	t = { "Toggle test file" },
}

which_key.register(mappings, opts)
which_key.register(ll_mappings, ll_opts)


