local keymap = vim.keymap
local cmd = vim.cmd

-- Search and scroll being kept in center.
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("n", "<C-f>", "<C-f>zz");
keymap.set("n", "<C-b>", "<C-b>zz");

-- Move block
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("n", "<leader>J", "mzJ`z")

-- Yank & Paste
keymap.set("x", "<leader>p", [["_dP]])
keymap.set("n", "<leader>P", [["+p]])
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

-- Buffer
keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>bp", "<cmd>bp<cr>")
keymap.set("n", "<leader>bn", "<cmd>bn<cr>")
keymap.set("n", "<leader>bl", "<cmd>bl<cr>")

-- Cheat sheet
local my_funs = require('config/functions')
keymap.set("n", "<leader>cc", my_funs.open_cheatsheet("tabe", ""))
keymap.set("n", "<leader>ch", my_funs.open_cheatsheet("belowright new", ""))
keymap.set("n", "<leader>cv", my_funs.open_cheatsheet("belowright vnew", ""))
keymap.set("n", "<leader>cjc", my_funs.open_cheatsheet("tabe", "java"))
keymap.set("n", "<leader>cjh", my_funs.open_cheatsheet("belowright new", "java"))
keymap.set("n", "<leader>cjv", my_funs.open_cheatsheet("belowright vnew", "java"))

-- Key maps for terminal split window
keymap.set("t", "<C-w>", "<C-\\><C-N><C-w>")

-- Misc
keymap.set("n", "<leader>B", "<cmd>suspend<cr>")
keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])
keymap.set("n", "<leader>X", "<cmd>!chmod +x %<cr>", { silent = true })
keymap.set("n", "<leader>qq", "<cmd>Ex<cr>")

-- Abbreviations
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
