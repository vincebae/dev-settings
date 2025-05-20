-- Search and scroll being kept in center.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Move block
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Yank & Paste
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<C-y>", [["+y]])
vim.keymap.set("x", "<leader>d", [["_d]])
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<leader>pc", [["+p]])
vim.keymap.set("n", "<leader>pd", [["1p]])
vim.keymap.set("n", "<leader>py", [["0p]])
vim.keymap.set("n", "<C-p>", [["+p]])

-- Windows
vim.keymap.set("n", "<C-]>", "<C-W>_<C-W>|")
vim.keymap.set("n", "<C-[>", "<C-W>=")
vim.keymap.set("n", "<C-v>", "<cmd>vsp<cr>")
vim.keymap.set("n", "<C-s>", "<cmd>sp<cr>")

-- Buffers
-- vim.keymap.set("n", "<leader>bd", "<cmd>%bd|e#|bd#<cr>")

-- Misc
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<cr>", { silent = true })
vim.keymap.set("n", "<leader>-", function()
    vim.cmd("e " .. vim.fn.getcwd())
end)


