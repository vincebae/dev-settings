vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.compatible = false
vim.opt.mouse = [[a]]

-- Visual
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
vim.opt.ruler = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"
vim.opt.foldcolumn = "3"
vim.opt.equalalways = false

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
    callback = function()
        vim.opt.cursorline = true
    end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    callback = function()
        vim.opt.cursorline = false
    end,
})

-- Lines
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.backspace = [[indent,eol,start]]

-- Encoding
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8"
vim.opt.ttyfast = true
vim.opt.fileformats = [[unix,dos,mac]]

-- Files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.opt.undofile = true
vim.opt.isfname:append("@-@")

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.showmatch = true
vim.opt.history = 1000

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Status line
vim.opt.statusline = " %F %M %Y %R %= asc: %b r: %l c: %c pct: %p%%"
vim.opt.laststatus = 2
vim.opt.showmode = false

-- Better command line completion
vim.opt.wildmenu = true
vim.opt.wildignore = "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx"

-- Misc
vim.opt.updatetime = 50
vim.opt.timeout = true
vim.opt.timeoutlen = 500
-- vim.opt.ttimeoutlen = 0
