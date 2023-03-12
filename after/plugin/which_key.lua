vim.o.timeout = true
vim.o.timeoutlen = 300

which_key = require("which-key")

local setup = {
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "center", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<cr>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = false, -- show help message on the command line when the popup is visible
	-- triggers = "auto", -- automatically setup triggers
	triggers = { "<leader>" }, -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		-- i = { "j", "k" },
		-- v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local v_opts = {
	mode = "v", -- VISUAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	e = { "Explorer" }, -- defined in nerdtree.lua
	f = { "Format" }, -- defined in lsp.lua
	B = { "Background" }, -- defined in remap.lua
	["/"] = { "Comment" }, -- defined in comment.lua
	u = { "Undotree" }, -- defined in undotree.lua
	t = {
		-- defined in telescope.lua
		name = "Telescope",
		b = { "Buffers" },
		f = { "Find Files" },
		g = { "Git Files" },
		l = { "Live Grep" },
		s = { "Find String" },
	},
	s = {
		-- defined in session.lua
		name = "Session",
		s = { "Save" },
		r = { "Restore" },
		d = { "Delete" },
		f = { "Search" },
	},
	h = {
		-- defined in harpoon.lua
		name = "Harpoon",
		a = { "Add File" },
		q = { "Quick Menu" },
		n = { "Next" },
		p = { "Prev" },
		["1"] = { "1st" },
		["2"] = { "2nd" },
		["3"] = { "3rd" },
		["4"] = { "4th" },
	},
	g = {
		-- defined in git.lua
		name = "Git",
		g = { "Git" },
		s = { "Status" },
	},
	l = {
		-- defined in lsp.lua
		name = "LSP",
		a = { "Action" },
		r = { "Rename" },
		D = { "Definition" },
		R = { "References" },
		h = { "Hover" },
		l = { "Open Lint" },
		n = { "Next" },
		d = { "Prev" },
		i = { "Info" },
	},
	p = {
		-- defined in packer.lua
		name = "Packer",
		i = { "Install" },
		c = { "Clean" },
		u = { "Update" },
		s = { "Sync" },
		S = { "Status" },
	},
}

local v_mappings = {
	["/"] = { "Comment" }, -- defined in comment.lua
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(v_mappings, v_opts)
