vim.keymap.set("n", "<leader>gg", vim.cmd.Git)
vim.keymap.set("n", "<leader>gs", "<cmd>Git status<cr>")

 --    -- g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },,
 --    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
 --    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
 --    l = { "<cmd>GitBlameToggle<cr>", "Blame" },
 --    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
 --    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
 --    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
 --    -- s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
 --    u = {
 --      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
 --      "Undo Stage Hunk",
 --    },
 --    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
 --    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
 --    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
 --    d = {
 --      "<cmd>Gitsigns diffthis HEAD<cr>",
 --      "Diff",
 --    },
 -- 
