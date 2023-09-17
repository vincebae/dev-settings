vim.opt.colorcolumn = "100"
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets(nil, {
	haskell = {
		s("script", {
			t({
				"#!/usr/bin/env stack",
				"-- stack --resolver lts-21.11 script",
				"",
			}),
		}),
		s("turtle", {
			t({
				"#!/usr/bin/env stack",
				"-- stack --resolver lts-21.11 script",
				"{-# LANGUAGE OverloadedStrings #-}",
				"",
				"import Turtle",
				"",
				"main = do",
				"  ",
			}),
		}),
	},
})
