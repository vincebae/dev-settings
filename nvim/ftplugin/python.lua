local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets("python", {
	s("shebang", {
		t({
			"#!/usr/bin/env python3",
			"",
		}),
	}),
}, { key = "python" })
