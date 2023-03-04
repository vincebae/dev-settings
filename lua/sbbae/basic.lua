local opt = vim.opt
local cmd = vim.cmd
local g = vim.g

g.mapleader = " "
opt.compatible = false
opt.mouse = [[a]]

-- Visual
opt.guicursor = ""
opt.ruler = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.scrolloff = 4
opt.signcolumn = "yes"
opt.colorcolumn = "80"

-- Lines
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false
opt.backspace = [[indent,eol,start]]

-- Encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileencodings = "utf-8"
opt.ttyfast = true
opt.fileformats = [[unix,dos,mac]]

-- Files
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
opt.undofile = true
opt.isfname:append("@-@")

-- Search
opt.hlsearch = false
opt.incsearch = true
opt.showmatch = true
opt.history = 1000

-- Status line
opt.statusline = " %F %M %Y %R %= asc: %b r: %l c: %c pct: %p%%"
opt.laststatus = 2

-- Better command line completion 
opt.wildmenu = true
opt.wildignore = "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx"

-- Misc
opt.updatetime = 50
