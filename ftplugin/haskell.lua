vim.opt.colorcolumn = "100"
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.g.haskell_tools = {
	hls = {
		on_attach = function(_, bufnr, ht)
			local function toggle_repl_current()
				ht.repl.toggle(vim.api.nvim_buf_get_name(0))
			end
			local function load_repl_current()
				ht.repl.load_file(vim.api.nvim_buf_get_name(0))
			end
			vim.api.nvim_create_user_command("HtReplToggleCurrent", toggle_repl_current, {})
			vim.api.nvim_create_user_command("HtReplLoadCurrent", load_repl_current, {})

			local opts = { buffer = bufnr, remap = false }
			local keymap = vim.keymap

            -- LSP keymaps
			keymap.set("n", "<leader>f", "<cmd>Format<cr>", opts)
			keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<cr>", opts)
			keymap.set("n", "<leader>lh", "<cmd>Lspsaga hover_doc<cr>", opts)
			keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<cr>", opts)
			keymap.set("n", "<leader>lP", "<cmd>Lspsaga peek_definition<cr>", opts)
			keymap.set("n", "<leader>lD", "<cmd>Lspsaga goto_definition<cr>", opts)
			keymap.set("n", "<leader>lR", "<cmd>Lspsaga finder<cr>", opts)
			keymap.set("n", "<leader>ll", "<cmd>Lspsaga show_buf_diagnostics<cr>", opts)
			keymap.set("n", "<leader>ln", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
			keymap.set("n", "<leader>lp", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)

            -- Eval keymaps
			keymap.set("n", "<localleader>el", vim.lsp.codelens.run, opts)
			keymap.set("n", "<localleader>eb", ht.lsp.buf_eval_all, opts)
			keymap.set("n", "<localleader>ed", ht.hoogle.hoogle_signature, opts)

            -- Repl keymaps
			keymap.set("n", "<localleader>ls", "<cmd>HtReplToggleCurrent<cr>", opts)
			keymap.set("n", "<localleader>lv", "<cmd>vsplit +HtReplToggleCurrent<cr><cmd>q<cr>", opts)
			keymap.set("n", "<localleader>lr", "<cmd>HtReplLoadCurrent<cr>", opts)
			keymap.set("n", "<localleader>lR", "<cmd>HtReplReload<cr>", opts)
			keymap.set("n", "<localleader>lq", ht.repl.quit, opts)
		end,
	},
}

local which_key = require("which-key")
local ll_opts = {
	mode = "n", -- NORMAL mode
	prefix = "<localleader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}
local ll_mappings = {
	l = {
		name = "REPL",
		s = { "Split down" },
		v = { "Split right" },
		r = { "Load Current File" },
		R = { "Reload" },
		q = { "Quit" },
	},
	e = {
		name = "Eval",
		b = { "Buffer" },
        l = { "CodeLens" },
		d = { "Doc (Hoogle)" },
	},
}
which_key.register(ll_mappings, ll_opts)

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
