return {
	-- Language specific LSP plugins
	{
		"ionide/Ionide-vim", -- fsharp language server
		ft = { "fsharp" },
	},
	{
		"mrcjkb/haskell-tools.nvim", -- haskell language server
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		version = "^2", -- Recommended
		ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
	},

	-- General LSP plugins
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			"neovim/nvim-lspconfig", -- Required
			"williamboman/mason.nvim", -- Optional
			"williamboman/mason-lspconfig.nvim", -- Optional

			-- Autocompletion
			"hrsh7th/nvim-cmp", -- Required
			"hrsh7th/cmp-nvim-lsp", -- Required
			"hrsh7th/cmp-buffer", -- Optional
			"hrsh7th/cmp-path", -- Optional
			"hrsh7th/cmp-nvim-lua", -- Optional
			"saadparwaiz1/cmp_luasnip", -- Optional

			-- Snippets
			"L3MON4D3/LuaSnip", -- Required

			-- Language specific
			{
				"PaterJason/cmp-conjure",
				ft = { "clojure" },
			},
		},

		config = function()
			local keymap = vim.keymap
			keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>")
			keymap.set("n", "<leader>lu", "<cmd>NullLsInfo<cr>")

			local on_attach_fn = function(_, bufnr)
				local opts = { buffer = bufnr, remap = false }
				keymap.set("n", "<leader>f", "<cmd>Format<cr>", opts)
				keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<cr>", opts)
				keymap.set("n", "<leader>r", "<cmd>Lspsaga rename<cr>", opts)
				keymap.set("n", "<leader>lh", "<cmd>Lspsaga hover_doc<cr>", opts)
				keymap.set("n", "gh", "<cmd>Lspsaga hover_doc<cr>", opts)
				keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<cr>", opts)
				keymap.set("n", "ga", "<cmd>Lspsaga code_action<cr>", opts)
				keymap.set("n", "<leader>lP", "<cmd>Lspsaga peek_definition<cr>", opts)
				keymap.set("n", "gP", "<cmd>Lspsaga peek_definition<cr>", opts)
				keymap.set("n", "<leader>lD", "<cmd>Lspsaga goto_definition<cr>", opts)
				keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<cr>", opts)
				keymap.set("n", "<leader>lR", "<cmd>Lspsaga finder<cr>", opts)
				keymap.set("n", "gr", "<cmd>Lspsaga finder<cr>", opts)
				keymap.set("n", "<leader>ll", "<cmd>Lspsaga show_buf_diagnostics<cr>", opts)
				keymap.set("n", "<leader>ln", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
				keymap.set("n", "gn", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
				keymap.set("n", "<leader>lp", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
				keymap.set("n", "gp", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
			end

			-- Setup LSP Zero
			local lsp_zero = require("lsp-zero")
			local lspconfig = require("lspconfig")

			-- lsp_zero.on_attach(on_attach_fn)

			-- Disable some LSPs in lsp-zero
			lsp_zero.skip_server_setup({
				"jdtls",
				"fsautocomplete",
				"hls",
				"metals",
			})
			-- lsp.preset({
			-- 	manage_nvim_cmp = {
			-- 		set_sources = "recommended",
			-- 	},
			-- })

			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"clojure_lsp",
					"lua_ls",
					"tsserver",
				},
				handlers = {
					lsp_zero.default_setup,
					lua_ls = function()
						local lua_opts = lsp_zero.nvim_lua_ls()
						lspconfig.lua_ls.setup(lua_opts)
					end,
					rust_analyzer = function()
						lspconfig.rust_analyzer.setup({
							settings = {
								["rust-analyzer"] = {
									assist = {
										importEnforceGranularity = true,
										importPrefix = "crate",
									},
									cargo = {
										allFeatures = true,
									},
									diagnostics = {
										enabled = true,
										experimental = {
											enable = true,
										},
									},
									checkOnSave = {
										allFeatures = true,
										overrideCommand = {
											"cargo",
											"clippy",
											"--workspace",
											"--message-format=json",
											"--all-targets",
											"--all-features",
										},
									},
								},
							},
						})
					end,
				},
			})

			-- lspconfig.metals.setup({})
			-- lspconfig.jdtls.setup({})

			lsp_zero.set_preferences({
				suggest_lsp_servers = false,
				sign_icons = {
					error = "E",
					warn = "W",
					hint = "H",
					info = "I",
				},
			})

			lsp_zero.on_attach(on_attach_fn)
			lsp_zero.setup()

			vim.diagnostic.config({
				virtual_text = true,
			})
			vim.lsp.set_log_level("off")

			-- Setup autocompletion.
			require("luasnip.loaders.from_vscode").lazy_load()

			local cmp = require("cmp")
			local cmp_action = lsp_zero.cmp_action()
			local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }
			cmp.setup({
				completion = {
					autocomplete = false,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip" },
					{ name = "orgmode" },
					{ name = "conjure" },
				},
				mapping = {
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping.select_next_item(cmp_select_opts),
					["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select_opts),
					["<C-f>"] = cmp_action.luasnip_jump_forward(),
					["<C-b>"] = cmp_action.luasnip_jump_backward(),
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})
		end,
	},
}
