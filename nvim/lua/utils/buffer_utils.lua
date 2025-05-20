-- Buffer management functions and keymaps
-- Copied from https://github.com/wilfreddenton/history.nvim and updated for my preference.

local path_utils = require("utils.path_utils")
local popup_utils = require("utils.popup_utils")

-- file types to be ignored
local IGNORES = {
    [""] = true,
    ["netrw"] = true,
    ["oil"] = true,
}

-- variable to store the current state of the buffer histroy, like
-- {
--   <winid> = {
--     index = 1, -- index of currentbuffer in bufs
--     bufs = {
--       { nr = <bufnr>, nm = <bufnm> },
--       ...
--     }
--   },
--   ...
-- }
local histories = {}

-- max item in the list per window.
local MAX_ITEMS = 12

local function is_buffer_listed(buf)
    return vim.bo[buf].buflisted
end

local function is_buffer_visible(buf)
    for _, winid in ipairs(vim.api.nvim_list_wins()) do
        if buf == vim.api.nvim_win_get_buf(winid) then
            return true
        end
    end
    return false
end

local function on_enter()
    local bufnr = vim.api.nvim_get_current_buf()
    local bufnm = path_utils.relative_path(vim.api.nvim_buf_get_name(bufnr))
    if bufnm == "" or IGNORES[vim.bo.filetype] or not is_buffer_listed(bufnr) then
        return
    end

    -- If this is the first buffer for the window, simply set the history and return.
    local winid = vim.api.nvim_get_current_win()
    local curr_buf = { nr = bufnr, nm = bufnm }
    local h = histories[winid]
    if not h then
        histories[winid] = { index = 1, bufs = { curr_buf } }
        return
    end

    -- If the last buf is same as this buf, no history update.
    local last_buf = h.bufs[h.index]
    if last_buf.nr == curr_buf.nr then
        return
    end

    -- Update buffer history and reset the index
    local new_bufs = { curr_buf }
    for i = h.index, #h.bufs do
        local buf = h.bufs[i]
        if buf.nr ~= curr_buf.nr then
            table.insert(new_bufs, buf)
        end
        if #new_bufs >= MAX_ITEMS then
            break
        end
    end

    -- Update the history
    histories[winid] = { index = 1, bufs = new_bufs }
end

local function on_delete()
    local bufnr = tonumber(vim.fn.expand("<abuf>"))
    if not bufnr or not is_buffer_listed(bufnr) then
        return
    end

    for winid, history in pairs(histories) do
        local new_bufs = {}
        local deleted_index = nil
        for index, buf in ipairs(history.bufs) do
            if buf.nr == bufnr then
                deleted_index = index
            else
                table.insert(new_bufs, buf)
            end
        end

        if deleted_index then
            local new_index = history.index
            if deleted_index < new_index then
                new_index = new_index - 1
            end
            histories[winid] = { index = new_index, bufs = new_bufs }
        end
    end
end

local function forward()
    local winid = vim.api.nvim_get_current_win()
    local h = histories[winid]
    if h and h.index > 1 then
        h.index = h.index - 1
        vim.api.nvim_set_current_buf(h.bufs[h.index].nr)
    end
end

local function back()
    local winid = vim.api.nvim_get_current_win()
    local h = histories[winid]
    if h and h.index < #h.bufs then
        h.index = h.index + 1
        vim.api.nvim_set_current_buf(h.bufs[h.index].nr)
    end
end

local function popup_select_menu()
    local winid = vim.api.nvim_get_current_win()
    local h = histories[winid]
    if not h or #h.bufs == 0 then
        return
    end

    local title = "Buffer History"
    local menuitems = {}
    for i, buf in ipairs(h.bufs) do
        table.insert(menuitems, { buf.nm, { winid = winid, index = i } })
    end

    local callbacks = {
        on_submit = function(item)
            vim.api.nvim_set_current_buf(h.bufs[item.index].nr)
        end,
    }
    local opts = {
        width = "80%",
        focus_linenr = h.index,
    }
    popup_utils.popup_menu(title, menuitems, callbacks, opts)
end

local function reset_curr_history()
    local winid = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_win_get_buf(winid)
    histories[winid] = nil
    vim.api.nvim_buf_call(buf, on_enter)
    vim.notify("Current buffer history reset")
end

local function reset_all_histories()
    histories = {}
    for _, winid in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(winid)
        vim.api.nvim_buf_call(buf, on_enter)
    end
    vim.notify("All buffer histories reset")
end

local function delete_buffer(buf)
    local confirmed = vim.api.nvim_buf_call(buf, function()
        if vim.bo.modified then
            local bufnm = path_utils.relative_path(vim.fn.bufname())
            local ok, choice = pcall(vim.fn.confirm, ("Save changes to %q?"):format(bufnm), "&Yes\n&No\n&Cancel")
            if not ok or choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
                return false
            end
            if choice == 1 then -- Yes
                vim.cmd.write()
            end
        end
        return true
    end)

    if confirmed and vim.api.nvim_buf_is_valid(buf) then
        pcall(vim.cmd, "bwipeout! " .. tostring(buf))
        return true
    else
        return false
    end
end

local function delete_all_invisible_buffers()
    local count = 0
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if is_buffer_listed(buf) and not is_buffer_visible(buf) then
            local result = delete_buffer(buf)
            if result then
                count = count + 1
            end
        end
    end
    vim.notify(tostring(count) .. " buffer(s) deleted")
end

return {
    histories = histories,
    on_enter = on_enter,
    on_delete = on_delete,
    forward = forward,
    back = back,
    popup_select_menu = popup_select_menu,
    reset_curr_history = reset_curr_history,
    reset_all_histories = reset_all_histories,
    delete_all_invisible_buffers = delete_all_invisible_buffers,
}
