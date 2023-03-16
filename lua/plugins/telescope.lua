local telescope = require("telescope")
local builtin = require("telescope.builtin")
local previewers = require("telescope.previewers")

return {
    "nvim-telescope/telescope.nvim",
    version = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "BurntSushi/ripgrep",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    keys = {
        { "<leader>tb", builtin.buffers },
        { "<leader>tf", builtin.find_files },
        { "<leader>tg", builtin.git_files },
        { "<leader>tl", builtin.live_grep },
        {
            "<leader>ts",
            function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end,
        },
    },
    config = function()
        -- telescope fzf extension setup
        -- You dont need to set any of these options. These are the default ones. Only
        -- the loading is important
        telescope.setup({
            defaults = {
                layout_strategy = "vertical",
                previewer = true,
                file_previewer = previewers.vim_buffer_cat.new,
                grep_previewer = previewers.vim_buffer_vimgrep.new,
                qflist_previewer = previewers.vim_buffer_qflist.new,
            },
            extensions = {
                fzf = {
                    fuzzy = true,    -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
            },
        })
        -- To get fzf loaded and working with telescope, you need to call
        -- load_extension, somewhere after setup function:
        telescope.load_extension("fzf")
    end,
}
