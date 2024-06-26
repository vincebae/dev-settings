vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt
opt.compatible = false
opt.mouse = [[a]]
-- opt.clipboard = 'unnamedplus'

-- Visual
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
opt.ruler = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.scrolloff = 4
opt.signcolumn = "yes"
opt.colorcolumn = "100"

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

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Status line
opt.statusline = " %F %M %Y %R %= asc: %b r: %l c: %c pct: %p%%"
opt.laststatus = 2

-- Better command line completion
opt.wildmenu = true
opt.wildignore = "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx"

-- Misc
opt.updatetime = 50
opt.timeoutlen = 1000

-- Racket filetype support
local api = vim.api
api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.scm", "*.ss", "*.sld" },
    command = "setf scheme",
})
api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.rkt", "*.rktd", "*.rktl" },
    command = "setf racket",
})
