local keymap = vim.keymap

-- Search and scroll being kept in center.
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<C-d>", "<C-d>zz")

-- Move block
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("n", "<leader>J", "mzJ`z")

-- Yank & Paste
keymap.set("x", "<leader>d", [["_d]])
keymap.set("x", "<leader>p", [["_dP]])
keymap.set("n", "<leader>pc", [["+p]])
keymap.set("n", "<leader>py", [["0p]])
keymap.set("n", "<leader>pd", [["1p]])
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

-- local function copy_to_clipboard()
--     vim.api.nvim_feedkeys([["+y]], "v", true)
--     vim.api.nvim_command("call writefile(getreg('+', 1, 1), '/tmp/nvim.clip')")
--     vim.api.nvim_command("!xsel -ib < /tmp/nvim.clip")
-- end
-- keymap.set("v", "<leader>y", copy_to_clipboard)

-- Windows
keymap.set("n", "<C-l>", "<C-W>l")
keymap.set("n", "<C-h>", "<C-W>h")
keymap.set("n", "<C-j>", "<C-W>j")
keymap.set("n", "<C-k>", "<C-W>k")
keymap.set("n", "<C-]>", "<C-W>_<C-W>|")
keymap.set("n", "<C-[>", "<C-W>=")
keymap.set("n", "<C-v>", "<cmd>vsp<cr>")
keymap.set("n", "<C-s>", "<cmd>sp<cr>")
keymap.set("t", "<C-t>", "<cmd>ToggleTerm<cr>")
keymap.set("n", "<C-t>", "<cmd>ToggleTerm direction=float<cr>")
keymap.set("n", "<leader>T", "<cmd>ToggleTerm direction=float<cr>")
-- keymap.set("n", "<localleader>t", "<cmd>ToggleTerm direction=vertical size=100<cr>")
-- keymap.set("n", "<localleader>T", "<cmd>ToggleTerm direction=horizontal size=25<cr>")

-- Buffer
keymap.set("n", "<leader>bt", "<cmd>ToggleTerm direction=vertical size=100<cr>")
keymap.set("n", "<leader>bT", "<cmd>ToggleTerm direction=horizontal size=25<cr>")
keymap.set("n", "<leader>bs", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>bp", "<cmd>bp<cr>")
keymap.set("n", "<leader>bn", "<cmd>bn<cr>")
keymap.set("n", "<leader>bl", "<C-^>")
keymap.set("n", "<leader>bdm", "<cmd>Bdelete menu<cr>")
keymap.set("n", "<leader>bdo", "<cmd>Bdelete other<cr>")
keymap.set("n", "<leader>bdh", "<cmd>Bdelete hidden<cr>")
keymap.set("n", "<leader>bda", "<cmd>Bdelete all<cr>")
keymap.set("n", "<leader>bdt", "<cmd>Bdelete this<cr>")
keymap.set("n", "<leader>bdn", "<cmd>Bdelete nameless<cr>")
keymap.set("n", "<leader>bds", "<cmd>Bdelete select<cr>")

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

-- Navigation
local my_funs = require("config/functions")
keymap.set("n", "<leader>nd", function()
	my_funs.cd_to_dir()
end)
keymap.set("n", "-", "<cmd>Oil<cr>")
keymap.set("n", "=", function()
    MiniFiles.open()
end)

-- Orgmode files
keymap.set("n", "<leader>oM", "<cmd>e ~/Documents/org/memo.org<cr>")
keymap.set("n", "<leader>oT", "<cmd>e ~/Documents/org/todo.org<cr>")
