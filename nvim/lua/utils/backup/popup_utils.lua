local Menu = require("nui.menu")

local popup_menu = function(title, menuitems, callbacks, opts)
    local lines = {}
    for k, v in ipairs(menuitems) do
        local line
        if type(v) == "table" then
            local text = v[1]
            local data = v[2] or {}
            line = Menu.item(text, data)
        else
            line = Menu.item(v)
        end
        table.insert(lines, k, line)
    end

    local popup_options = {
        position = "50%",
        border = {
            style = "single",
            text = {
                top = title,
                top_align = "center",
            },
        },
        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal",
        },
    }

    opts = opts or {}
    if opts.width then
        popup_options.size = { width = opts.width }
    end

    local menu = Menu(popup_options, {
        lines = lines,
        keymap = {
            focus_next = { "j", "<Down>", "<Tab>" },
            focus_prev = { "k", "<Up>", "<S-Tab>" },
            close = { "<Esc>", "<C-c>", "q" },
            submit = { "<CR>", "<Space>" },
        },
        on_submit = callbacks.on_submit,
        on_close = callbacks.on_close,
        on_change = callbacks.on_change,
    })

    menu:mount()

    if opts.focus_linenr and opts.focus_linenr > 1 and opts.focus_linenr <= #lines then
        for linenr = opts.focus_linenr, #menu.tree:get_nodes() do
            local node, target_linenr = menu.tree:get_node(linenr)
            if not menu._.should_skip_item(node) then
                vim.api.nvim_win_set_cursor(menu.winid, { target_linenr, 0 })
                menu._.on_change(node)
                break
            end
        end
    end

    -- disable "-" key (oil)
    vim.api.nvim_buf_set_keymap(menu.bufnr, "n", "-", "<Nop>", { noremap = true, silent = true })
end

return {
    popup_menu = popup_menu,
}
