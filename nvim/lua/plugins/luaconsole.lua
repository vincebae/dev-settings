return {
    "yarospace/lua-console.nvim",
    lazy = true,
    keys = {
        { "<leader>`", desc = "Toggle Lua Console" },
        { "<leader>~", desc = "Attach to Lua Console" },
    },
    opts = {
        mappings = {
            toggle = "<leader>`", -- toggle console
            attach = "<leader>~", -- attach console to a buffer
        },
    },
}
