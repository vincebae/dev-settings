return {
    "mfussenegger/nvim-jdtls",   -- java language server
    {
        "scalameta/nvim-metals", -- scala language server
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "mrcjkb/haskell-tools.nvim", -- haskell language server
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim", -- optional
        },
        branch = "1.x.x",                    -- recommended
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        dependencies = {
            -- LSP Support
            "neovim/nvim-lspconfig",             -- Required
            "williamboman/mason.nvim",           -- Optional
            "williamboman/mason-lspconfig.nvim", -- Optional
            -- Autocompletion
            "hrsh7th/nvim-cmp",                  -- Required
            "hrsh7th/cmp-nvim-lsp",              -- Required
            "hrsh7th/cmp-buffer",                -- Optional
            "hrsh7th/cmp-path",                  -- Optional
            "hrsh7th/cmp-nvim-lua",              -- Optional
            "saadparwaiz1/cmp_luasnip",          -- Optional
            -- Snippets
            "L3MON4D3/LuaSnip",                  -- Required
            "rafamadriz/friendly-snippets",      -- Optional
        },
        config = function()
            local keymap = vim.keymap
            local diagnostic = vim.diagnostic
            local vlsp = vim.lsp
            local lsp = require("lsp-zero")

            lsp.preset("recommended")

            lsp.ensure_installed({
                "bashls",
                "hls",
                "lua_ls",
                "rust_analyzer",
                "tsserver",
            })

            lsp.set_preferences({
                suggest_lsp_servers = false,
                sign_icons = {
                    error = "E",
                    warn = "W",
                    hint = "H",
                    info = "I",
                },
            })

            lsp.configure("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })

            lsp.configure("rust_analyzer", {
                settings = {
                    ['rust-analyzer'] = {
                        assist = {
                            importEnforceGranularity = true,
                            importPrefix = 'crate',
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
                                'cargo', 'clippy', '--workspace', '--message-format=json',
                                '--all-targets', '--all-features'
                            }
                        }
                    },
                },
            })

            -- Disable some LSPs in lsp-zero
            -- jdtls will be initialized by nvim.jdtls in ftplugin/java.lua
            lsp.skip_server_setup({ "jdtls" })

            local on_attach_fn = function(_, bufnr)
                local opts = { buffer = bufnr, remap = false }

                keymap.set("n", "<leader>f", vlsp.buf.format, opts)

                keymap.set("n", "<leader>lh", vlsp.buf.hover, opts)
                keymap.set("n", "<leader>la", vlsp.buf.code_action, opts)

                keymap.set("n", "<leader>lr", vlsp.buf.rename, opts)
                keymap.set("n", "<leader>lD", vlsp.buf.definition, opts)
                keymap.set("n", "<leader>lR", vlsp.buf.references, opts)

                keymap.set("n", "<leader>ll", diagnostic.open_float, opts)
                keymap.set("n", "<leader>ln", diagnostic.goto_next, opts)
                keymap.set("n", "<leader>lp", diagnostic.goto_prev, opts)

                keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>")
            end
            lsp.on_attach(on_attach_fn)
            lsp.setup()

            vim.diagnostic.config({
                virtual_text = true,
            })
        end,
    },
}
