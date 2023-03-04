local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
    [[  ____  _   __      ___           ]],
    [[ |  _ \(_)  \ \    / (_)          ]],
    [[ | |_) |_ _ _\ \  / / _ _ __ ___  ]],
    [[ |  _ <| | '_ \ \/ / | | '_ ` _ \ ]],
    [[ | |_) | | | | \  /  | | | | | | |]],
    [[ |____/|_|_| |_|\/   |_|_| |_| |_|]],
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button("e", "  > New file" ,
                     ":ene <BAR> startinsert <CR>"),
    dashboard.button("f", "  > Find file",
                     ":cd $HOME/code | Telescope find_files<CR>"),
    dashboard.button("r", "  > Recent"   ,
                     ":Telescope oldfiles<CR>"),
    dashboard.button("s", "  > Settings" ,
                     ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    dashboard.button("q", "  > Quit NVIM",
                     ":qa<CR>"),
}
                                  
-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
                                  

