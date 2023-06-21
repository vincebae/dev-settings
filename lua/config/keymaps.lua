local keymap = vim.keymap

-- Search and scroll being kept in center.
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("n", "<C-f>", "<C-f>zz")
keymap.set("n", "<C-b>", "<C-b>zz")

-- Move block
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("n", "<leader>J", "mzJ`z")

-- Yank & Paste
keymap.set("x", "<leader>d", [["_d]])
keymap.set("x", "<leader>p", [["_dP]])
keymap.set("n", "<leader>P", [["+p]])
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

-- Windows
keymap.set("n", "<C-l>", "<C-W>l")
keymap.set("n", "<C-h>", "<C-W>h")
keymap.set("n", "<C-j>", "<C-W>j")
keymap.set("n", "<C-k>", "<C-W>k")
keymap.set("n", "<C-\\>", "<C-W>_<C-W>|")
keymap.set("n", "<C-v>", "<cmd>vsp<cr>")
keymap.set("n", "<C-x>", "<cmd>sp<cr>")
keymap.set("n", "<leader>T", "<cmd>vertical bo split +terminal<cr>")

-- Buffer
keymap.set("n", "<leader>bs", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>bp", "<cmd>bp<cr>")
keymap.set("n", "<leader>bn", "<cmd>bn<cr>")
keymap.set("n", "<leader>bl", "<C-^>")

-- Tab
keymap.set("n", "<leader>ww", "<cmd>Telescope telescope-tabs list_tabs<cr>")
keymap.set("n", "<leader>w<leader>", "<cmd>tabnew<cr>")
keymap.set("n", "<leader>wn", "<cmd>tabnext<cr>")
keymap.set("n", "<leader>wp", "<cmd>tabprev<cr>")
keymap.set("n", "<leader>wc", "<cmd>tabclose<cr>")
keymap.set("n", "<leader>wo", "<cmd>tabonly<cr>")

-- Key maps for terminal split window
keymap.set("t", "<C-w>", "<C-\\><C-N><C-w>")

-- Misc
keymap.set("n", "<leader>B", "<cmd>suspend<cr>")
keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])
keymap.set("n", "<leader>X", "<cmd>!chmod +x %<cr>", { silent = true })

-- Abbreviations
local cmd = vim.cmd
cmd("cnoreabbrev W! w!")
cmd("cnoreabbrev Q! q!")
cmd("cnoreabbrev Qall! qall!")
cmd("cnoreabbrev Wq wq")
cmd("cnoreabbrev Wa wa")
cmd("cnoreabbrev wQ wq")
cmd("cnoreabbrev WQ wq")
cmd("cnoreabbrev W w")
cmd("cnoreabbrev Q q")
cmd("cnoreabbrev Qall qall")

-- Navigation
local my_funs = require("config/functions")
-- vim.api.nvim_create_user_command("Totop", my_funs.cd_to_top_dir, {})
-- vim.api.nvim_create_user_command("Totest", my_funs.cd_to_test_dir, {})
-- vim.api.nvim_create_user_command("Tomain", my_funs.cd_to_main_dir, {})
-- vim.api.nvim_create_user_command("Tocurr", my_funs.cd_to_curr_dir, {})
-- vim.api.nvim_create_user_command("Todir", my_funs.cd_to_dir, {})
-- vim.api.nvim_create_user_command("Etest", my_funs.open_test_file, {})
-- vim.api.nvim_create_user_command("Emain", my_funs.open_main_file, {})
--

keymap.set("n", "<leader>nd", function() my_funs.cd_to_dir() end)
keymap.set("n", "-", "<cmd>Oil<cr>")

-- Orgmode files
keymap.set("n", "<leader>oM", "<cmd>e ~/Documents/org/memo.org<cr>")
keymap.set("n", "<leader>oT", "<cmd>e ~/Documents/org/todo.org<cr>")
