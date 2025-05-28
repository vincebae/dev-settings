local filetypes = { "java", "clojure" } -- "scala", "sbt"
return {
    "mfussenegger/nvim-jdtls", -- java language server
    ft = filetypes,
    dependencies = {
        "mfussenegger/nvim-dap",
        "mason-org/mason.nvim",
    },
    config = function()
        local jdtls = require("jdtls")
        local setup = require("jdtls.setup")

        local jdtls_root_path = vim.fn.expand("$MASON/packages/jdtls")
        local jdtls_cmd_path = jdtls_root_path .. "/jdtls"
        local config_dir = jdtls_root_path .. "/config_mac_arm"
        local project_root = setup.find_root({ ".git", "mvnw", "gradlew", "build.sbt" })
        local project_name = vim.fn.fnamemodify(project_root, ":p:h:t")
        local data_dir = vim.fn.expand("$HOME/.cache/jdtls/workspace/") .. project_name

        local config = {
            cmd = {
                jdtls_cmd_path,
                "-configuration",
                config_dir,
                "-data",
                data_dir,
            },
            root_dir = project_root,
            capabilities = require("blink.cmp").get_lsp_capabilities(),
        }

        local nvim_jdtls_group = vim.api.nvim_create_augroup("nvim-jdtls", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetypes,
            callback = function()
                jdtls.start_or_attach(config)
            end,
            group = nvim_jdtls_group,
        })
    end,
}
