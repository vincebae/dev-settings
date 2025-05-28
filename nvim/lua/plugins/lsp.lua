return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp",

            -- Picker
            "folke/snacks.nvim",

            -- Language specific
            -- TODO: check compatibility with blink.cmp
            -- {
            -- 	"PaterJason/cmp-conjure",
            -- 	ft = { "clojure" },
            -- },
        },

        config = function()
            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            local lspconfig = require("lspconfig")
            local lspconfig_defaults = lspconfig.util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                "force",
                lspconfig_defaults.capabilities,
                require("blink.cmp").get_lsp_capabilities()
            )

            -- This is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }
                    vim.keymap.set("n", "gn", "<cmd>Lspsaga rename<cr>", opts)
                    vim.keymap.set("n", "gh", "<cmd>Lspsaga hover_doc<cr>", opts)
                    vim.keymap.set("n", "ga", "<cmd>Lspsaga code_action<cr>", opts)
                    vim.keymap.set("n", "gb", "<cmd>Lspsaga show_buf_diagnostics<cr>", opts)
                    vim.keymap.set("n", "gs", "<cmd>Lspsaga show_cursor_diagnostics<cr>", opts)
                    vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
                    vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
                    vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<cr>", opts)

                    vim.keymap.set("n", "gd", Snacks.picker.lsp_definitions, opts)
                    vim.keymap.set("n", "gr", Snacks.picker.lsp_references, opts)
                    vim.keymap.set("n", "gi", Snacks.picker.lsp_implementations, opts)
                end,
            })

            vim.lsp.enable({
                "bashls",
                "clojure_lsp",
                "fennel_language_server",
                "lua_ls",
            })
        end,
    },
}
