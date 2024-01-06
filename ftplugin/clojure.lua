vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Confure auto repl
local project_file = io.open("project.clj")
if project_file ~= nil then
	io.close(project_file)
	vim.cmd([[let g:conjure#client#clojure#nrepl#connection#auto_repl#cmd = "lein repl :headless :port $port"]])
else
	vim.cmd([[let g:conjure#client#clojure#nrepl#connection#auto_repl#cmd = "bb nrepl-server $port"]])
end

-- File navigation
local my_funs = require("config/functions")
local open_test_file = function()
	local src_file_pattern = [[/src/(.*/[^/]+).clj(s*)$]]
	local test_file_pattern = [[/test/%1_test.clj%2]]
	my_funs.open_file_by_pattern(src_file_pattern, test_file_pattern)
end

local open_src_file = function()
	local test_file_pattern = [[/test/(.*/[^/]+)_test.clj(s*)$]]
	local src_file_pattern = [[/src/%1.clj%2]]
	my_funs.open_file_by_pattern(test_file_pattern, src_file_pattern)
end

local cd_to_test_dir = function()
	local src_dir_pattern = [[/src/]]
	local test_dir_pattern = [[/test/]]
	my_funs.open_dir_by_pattern(src_dir_pattern, test_dir_pattern)
end

local cd_to_src_dir = function()
	local test_dir_pattern = [[/test/]]
	local src_dir_pattern = [[/src/]]
	my_funs.open_dir_by_pattern(test_dir_pattern, src_dir_pattern)
end

local cd_to_top_dir = function()
	local curr_dir = my_funs.get_current_dir()
	if string.find(curr_dir, [[/src/]]) then
		my_funs.open_dir_by_pattern([[/src/.*$]], "")
	else
		my_funs.open_dir_by_pattern([[/test/.*$]], "")
	end
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

local eval_str = function()
	local expr = vim.fn.input("Expr > ")
	vim.cmd("ConjureEval " .. expr)
end
local doc_str = function()
	local expr = vim.fn.input("Symbol > ")
	vim.cmd("ConjureEval (clojure.repl/doc " .. expr .. ")")
end
local eval_and_test_ns = function()
	vim.cmd("ConjureEvalFile")
	vim.cmd("ConjureCljRunCurrentNsTests")
end

keymap.set("n", "<localleader>es", function()
	eval_str()
end)
keymap.set("n", "<localleader>ed", function()
	doc_str()
end)
keymap.set("n", "<localleader>tt", function()
	eval_and_test_ns()
end)

-- Clojure specific which-key mapping
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

local ll_v_opts = {
	mode = "v", -- VISUAL mode
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
		T = { "Open test dir" },
		S = { "Open main dir" },
		t = { "Open test file" },
		s = { "Open main file" },
		d = { "Open dir" },
	},
}

local ll_mappings = {
	-- Navigations
	P = { "Open top dir" },
	T = { "Open test dir" },
	S = { "Open main dir" },
	t = { "Open test file" },
	s = { "Open main file" },

	c = {
		name = "Conjure Connection",
		c = { "<cmd>ConjureConnect<cr>", "Connect" },
		p = {
			function()
				local port = vim.fn.input("Port > ", "1667")
				vim.cmd("ConjureConnect " .. port)
			end,
			"Connect to port",
		},
		s = {
			function()
				local key = vim.fn.input("Key > ")
				vim.cmd("ConjureClientState " .. key)
			end,
			"Client state",
		},
	},

	l = {
		name = "Log buffer",
		s = { "Split down" },
		v = { "Split right" },
		t = { "New tab" },
		e = { "Current window" },
		q = { "Close all in tab" },
		r = { "Soft reset" },
		R = { "Hard reset" },
		l = { "Latest result" },
	},

	E = "Evaluate motion",

	e = {
		name = "Evaluate",
		e = { "Innermost" },
		r = { "Outermost" },
		w = { "Word" },
		f = { "File" },
		b = { "Buffer" },
		["!"] = { "Eval and replace" },
		c = {
			name = "Evaluate and comment",
			e = { "Innermost" },
			r = { "Outermost" },
			w = { "Word" },
		},
		t = {
			name = "Testing",
			a = { "All loaded" },
			n = { "All curr ns" },
			t = { "Eval file and Test curr ns" },
			N = { "All alt ns" },
			c = { "Cursor" },
		},

		i = { "Interrupt" },
		s = { "Input" },
		d = { "Doc" },
	},

	v = {
		name = "View",
		e = { "Last exception" },
		s = { "Source" },
		d = { "<cmd>ConjureDocWord<cr>", "Doc" },
		["1"] = { "Most recent eval" },
		["2"] = { "2nd Most recent eval" },
		["3"] = { "3rd Most recent eval" },
	},

	r = {
		name = "Refresh",
		r = { "All changed" },
		a = { "All" },
		c = { "Clear cache" },
	},
}

local ll_v_mappings = {
	E = "Evaluate",
}

which_key.register(mappings, opts)
which_key.register(ll_mappings, ll_opts)
which_key.register(ll_v_mappings, ll_v_opts)

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets(nil, {
	clojure = {
		s("scr", {
			t({
				"#!/usr/bin/env bb",
				"",
			}),
		}),
		s("shell", {
			t({
				"(require '[babashka.process :refer [sh]])",
				"",
			}),
		}),
		s("test", {
			t({
				"(require '[clojure.test :refer [deftest is testing]]])",
				"",
			}),
		}),
	},
})
