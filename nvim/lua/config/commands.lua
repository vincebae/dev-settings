-- Clojure specific auto commands
local clj = require("utils.clj_utils")

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "clojure",
--     once = true,
--     callback = function()
--         vim.schedule(function()
--             clj.start_nrepl_server()
--         end)
--     end,
-- })

-- Connect to the port from the user input
local function connect_to_input_port()
    local port = vim.fn.input("Port > ", "")
    if port and port ~= "" then
        vim.cmd("ConjureConnect " .. port)
    end
end

local function configure_clojure_keymap()
    vim.keymap.set(
        "n",
        "<localleader>cc",
        "<cmd>ConjureCljConnectPortFile<cr>",
        { buffer = true, desc = "Connect to port in .nrepl-server file" }
    )
    vim.keymap.set(
        "n",
        "<localleader>ci",
        connect_to_input_port,
        { buffer = true, desc = "Connect to specific input port" }
    )
    vim.keymap.set("n", "<localleader>cn", clj.start_nrepl_server, { buffer = true, desc = "Start nREPL Server" })
    vim.keymap.set("n", "<localleader>ed", clj.doc_str, { buffer = true, desc = "Doc Input String" })
    vim.keymap.set("n", "<localleader>nr", clj.reload_namespace, { buffer = true, desc = "Reload Namespace" })
    vim.keymap.set("n", "<localleader>ns", clj.into_namespace, { buffer = true, desc = "Into Namespace" })
    vim.keymap.set("n", "<localleader>nt", clj.test_namespace, { buffer = true, desc = "Test Namespace" })

    local which_key = require("which-key")
    which_key.add({
        buffer = true,
        { "<localleader>n", group = "Clojure Namespace" },
        -- Disable default keymap
        { "<localleader>cf", "<nop>", hidden = true },
    })
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "clojure",
    callback = function()
        vim.schedule(configure_clojure_keymap)
    end,
})

-- List specific auto commands
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lisp",
    once = true,
    callback = function()
        vim.schedule(function()
            vim.cmd([[call vlime#server#New(v:true, get(g:, "vlime_cl_use_terminal", v:false))]])
            vim.cmd([[call vlime#plugin#CloseWindow("server")]])
        end)
    end,
})
