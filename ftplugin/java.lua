vim.opt.colorcolumn = "100"
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- LSP
-- local jdtls = require("jdtls")
-- local setup = require("jdtls.setup")
--
-- local mason_path = vim.fn.expand("$HOME/.local/share/nvim/mason")
-- local jdtls_path = mason_path .. "/bin/jdtls"
-- local lombok_path = mason_path .. "/packages/jdtls/lombok.jar"
-- local config = {
-- 	cmd = {
-- 		jdtls_path,
-- 		"--jvm-arg=-javaagent:" .. lombok_path,
-- 	},
-- 	handlers = {
-- 		-- ['language/status'] = function(_, result)
-- 		--     -- Print or whatever.
-- 		-- end,
-- 	},
-- 	root_dir = setup.find_root({ ".git", "mvnw", "gradlew" }),
-- 	capabilities = require("cmp_nvim_lsp").default_capabilities(),
-- }
--
-- jdtls.start_or_attach(config)

-- Navigation
local my_funs = require("config/functions")
local open_test_file = function()
	local src_file_pattern = [[/src/main/(.*/[%a%d]+).java$]]
	local test_file_pattern = [[/src/test/%1Test.java]]
	my_funs.open_file_by_pattern(src_file_pattern, test_file_pattern)
end

local open_src_file = function()
	local test_file_pattern = [[/src/test/(.*/[%a%d]+)Test.java$]]
	local src_file_pattern = [[/src/main/%1.java]]
	my_funs.open_file_by_pattern(test_file_pattern, src_file_pattern)
end

local cd_to_test_dir = function()
	local src_dir_pattern = [[/src/main/]]
	local test_dir_pattern = [[/src/test/]]
	my_funs.open_dir_by_pattern(src_dir_pattern, test_dir_pattern)
end

local cd_to_src_dir = function()
	local test_dir_pattern = [[/src/test/]]
	local src_dir_pattern = [[/src/main/]]
	my_funs.open_dir_by_pattern(test_dir_pattern, src_dir_pattern)
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
	cd_to_test_dir()
end)
keymap.set("n", "<leader>nS", function()
	cd_to_src_dir()
end)
keymap.set("n", "<leader>nt", function()
	open_test_file()
end)
keymap.set("n", "<leader>ns", function()
	open_src_file()
end)

-- Java specific which-key mapping
local which_key = require("which-key")
local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	n = {
		name = "Navigation",
		P = { "Open top dir" },
		T = { "Open test dir" },
		S = { "Open main dir" },
		t = { "Open test file" },
		s = { "Open main file" },
		d = { "Open dir" },
	},
}

which_key.register(mappings, opts)

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node

local get_package_name = function()
	local path = vim.fn.expand("%:p:h")
	local extracted = string.match(path, [[.*/src/%a+/java/(.*)]])
	if extracted ~= nil then
		return string.gsub(extracted, "/", ".")
	else
		return ""
	end
end

local get_class_name = function()
	local filename = vim.fn.expand("%:t")
	return string.gsub(filename, ".java$", "")
end

ls.add_snippets(nil, {
	java = {
		s("package", {
			t("package "),
			f(get_package_name, {}),
			t({ ";", "" }),
		}),
		s("logger", {
			t("private static final Logger LOGGER = LoggerFactory.getLogger("),
			f(get_class_name, {}),
			t({ ".class);", "" }),
		}),
		s("junit5", {
			t({
				"import static org.hamcrest.MatcherAssert.assertThat;",
				"import static org.hamcrest.Matchers.is;",
				"import static org.junit.jupiter.api.Assertions.assertThrows;",
				"import static org.mockito.Mockito.doReturn;",
                "import static org.mockito.ArgumentMatchers.any;",
				"",
			}),
		}),
	},
})
