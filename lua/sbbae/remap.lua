-- Search and scroll being kept in center.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-f>", "<C-f>zz");
vim.keymap.set("n", "<C-b>", "<C-b>zz");

-- Move block
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>J", "mzJ`z")

-- Yank & Paste
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<leader>P", [["+p]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Key maps for terminal split window
vim.keymap.set("t", "<C-w>", "<C-\\><C-N><C-w>")

-- Misc
vim.keymap.set("n", "<leader>B", "<cmd>suspend<cr>")
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<cr>", { silent = true })
vim.keymap.set("n", "<leader>qq", "<cmd>Ex<cr>")

-- Abbreviations
vim.cmd("cnoreabbrev W! w!")
vim.cmd("cnoreabbrev Q! q!")
vim.cmd("cnoreabbrev Qall! qall!")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev Wa wa")
vim.cmd("cnoreabbrev wQ wq")
vim.cmd("cnoreabbrev WQ wq")
vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev Q q")
vim.cmd("cnoreabbrev Qall qall")
