vim.opt.colorcolumn = "120"

local ju = require("utils.java_utils")
local pu = require("utils.popup_utils")

local test_env = "slime"
local function choose_test_env_menu()
    local title = "Choose Test Enviroment"
    local menuitems = {
        { "Slime", { value = "slime" }},
        { "Terminal", { value = "terminal"}},
    }
    local callbacks = {
        on_submit = function(item)
            test_env = item.value
        end
    }
    local opts = { width = 24 }
    pu.popup_menu(title, menuitems, callbacks, opts)
end
vim.api.nvim_create_user_command("ChooseTestEnv", choose_test_env_menu, {})

vim.api.nvim_create_user_command("TestAll", function()
    ju.run_test_all({ env = test_env, debug = false })
end, {})
vim.api.nvim_create_user_command("TestClass", function()
    ju.run_test_class({ env = test_env, debug = false })
end, {})
vim.api.nvim_create_user_command("TestMethod", function()
    ju.run_test_method({ env = test_env, debug = false })
end, {})
vim.api.nvim_create_user_command("TestAllDebug", function()
    ju.run_test_all({ env = test_env, debug = true })
end, {})
vim.api.nvim_create_user_command("TestClassDebug", function()
    ju.run_test_class({ env = test_env, debug = true })
end, {})
vim.api.nvim_create_user_command("TestMethodDebug", function()
    ju.run_test_method({ env = test_env, debug = true })
end, {})

-- aliases
vim.cmd("command! Ta TestAll")
vim.cmd("command! TA TestAll")
vim.cmd("command! Tc TestClass")
vim.cmd("command! TC TestClass")
vim.cmd("command! Tm TestMethod")
vim.cmd("command! TM TestMethod")
vim.cmd("command! Tad TestAllDebug")
vim.cmd("command! TAD TestAllDebug")
vim.cmd("command! Tcd TestClassDebug")
vim.cmd("command! TCD TestClassDebug")
vim.cmd("command! Tmd TestMethodDebug")
vim.cmd("command! TMD TestMethodDebug")

-- Java specific Snippets
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

ls.add_snippets("java", {
    s("package_auto", {
        t("package "),
        f(ju.get_package_name, {}),
        t({ ";", "" }),
    }),
    s("logger", {
        t("private static final Logger LOGGER = Logger.getLogger("),
        f(ju.get_class_name, {}),
        t({ ".class);", "" }),
    }),
    s("import_logger", {
        t("import org.jboss.logging.Logger;"),
    }),
}, { key = "java" })
