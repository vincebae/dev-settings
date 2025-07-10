-- [nfnl] nvim/fnl/utils/buffer_utils.fnl
local path_utils = require("utils.path_utils")
local popup_utils = require("utils.popup_utils")
local IGNORES = {"", "netrw", "oil"}
local MAX_ITEMS = 12
local histories = {}
local function buffer_listed_3f(buf)
  local tmp_3_ = vim.bo
  if (nil ~= tmp_3_) then
    local tmp_3_0 = tmp_3_[buf]
    if (nil ~= tmp_3_0) then
      return tmp_3_0.buflisted
    else
      return nil
    end
  else
    return nil
  end
end
local function buffer_visible_3f(buf)
  local visible_3f = false
  for _, winid in ipairs(vim.api.nvim_list_wins()) do
    if visible_3f then break end
    visible_3f = (buf == vim.api.nvim_win_get_buf(winid))
  end
  return visible_3f
end
local function on_enter()
  local function new_buffer_info(bufnr, bufnm)
    local _3_
    do
      local s_19_auto = bufnm
      _3_ = (s_19_auto and (s_19_auto ~= ""))
    end
    local _4_
    do
      local found_3f_4_auto = false
      for __5_auto, value_6_auto in pairs(IGNORES) do
        if found_3f_4_auto then break end
        found_3f_4_auto = (value_6_auto == vim.bo.filetype)
      end
      _4_ = found_3f_4_auto
    end
    if (_3_ and not _4_ and buffer_listed_3f(bufnr)) then
      return {nr = bufnr, nm = bufnm}
    else
      return nil
    end
  end
  local function insert_buffer_to_history(buffer_info, history)
    local buffers = {buffer_info}
    for i = history.index, #history.bufs do
      if (#buffers >= MAX_ITEMS) then break end
      local buf = history.bufs[i]
      if (buffer_info.nr ~= buf.nr) then
        table.insert(buffers, buf)
      else
      end
    end
    return buffers
  end
  local function new_buffer_list(buffer_info, history)
    if (history == nil) then
      return {buffer_info}
    elseif (buffer_info.nr == history.bufs[history.index].nr) then
      return nil
    else
      return insert_buffer_to_history(buffer_info, history)
    end
  end
  local function update_history(buffers, winid)
    histories[winid] = {index = 1, bufs = buffers}
    return nil
  end
  local bufnr = vim.api.nvim_get_current_buf()
  local bufnm = path_utils["relative-path"](vim.api.nvim_buf_get_name(bufnr))
  local winid = vim.api.nvim_get_current_win()
  local history = histories[winid]
  local tmp_3_ = new_buffer_info(bufnr, bufnm)
  if (nil ~= tmp_3_) then
    local tmp_3_0 = new_buffer_list(tmp_3_, history)
    if (nil ~= tmp_3_0) then
      return update_history(tmp_3_0, winid)
    else
      return nil
    end
  else
    return nil
  end
end
local function on_delete()
  local function find_index(bufnr, history)
    local result = nil
    for index, buf in ipairs(history.bufs) do
      if result then break end
      if (bufnr == buf.nr) then
        result = index
      else
        result = nil
      end
    end
    return result
  end
  local function new_history(bufnr, history)
    local target_index = find_index(bufnr, history)
    if target_index then
      local buffers
      do
        local tbl_21_ = {}
        local i_22_ = 0
        for i, buf in ipairs(history.bufs) do
          local val_23_
          if (target_index ~= i) then
            val_23_ = buf
          else
            val_23_ = nil
          end
          if (nil ~= val_23_) then
            i_22_ = (i_22_ + 1)
            tbl_21_[i_22_] = val_23_
          else
          end
        end
        buffers = tbl_21_
      end
      local curr_index = history.index
      local new_index
      if (target_index < curr_index) then
        new_index = (curr_index - 1)
      else
        new_index = curr_index
      end
      return {index = new_index, bufs = buffers}
    else
      return nil
    end
  end
  local bufnr = tonumber(vim.fn.expand("<abuf>"))
  if (bufnr and buffer_listed_3f(bufnr)) then
    for winid, history in pairs(histories) do
      histories[winid] = new_history(bufnr, history)
    end
    return nil
  else
    return nil
  end
end
local function forward()
  local winid = vim.api.nvim_get_current_win()
  local h = histories[winid]
  if (h and (h.index > 1)) then
    h.index = (h.index - 1)
    return vim.api.nvim_set_current_buf(h.bufs[h.index].nr)
  else
    return nil
  end
end
local function back()
  local winid = vim.api.nvim_get_current_win()
  local h = histories[winid]
  if (h and (h.index < #h.bufs)) then
    h.index = (h.index + 1)
    return vim.api.nvim_set_current_buf(h.bufs[h.index].nr)
  else
    return nil
  end
end
local function popup_select_menu()
  local function create_menu_items(winid, buffers)
    local tbl_21_ = {}
    local i_22_ = 0
    for i, buf in ipairs(buffers) do
      local val_23_ = {buf.nm, {winid = winid, index = i}}
      if (nil ~= val_23_) then
        i_22_ = (i_22_ + 1)
        tbl_21_[i_22_] = val_23_
      else
      end
    end
    return tbl_21_
  end
  local function create_callbacks(buffers)
    local function _19_(item)
      return vim.api.nvim_set_current_buf(buffers[item.index].nr)
    end
    return {on_submit = _19_}
  end
  local function create_opts(index)
    return {width = "80%", focus_linenr = index}
  end
  local winid = vim.api.nvim_get_current_win()
  local history = histories[winid]
  local _20_
  do
    local x_2_auto = history.bufs
    _20_ = (x_2_auto and (#x_2_auto > 0))
  end
  if _20_ then
    return popup_utils["popup-menu"]("Buffer history", create_menu_items(winid, history.bufs), create_callbacks(history.bufs), create_opts(history.index))
  else
    return nil
  end
end
local function clear_curr_history()
  local winid = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_win_get_buf(winid)
  histories[winid] = nil
  vim.api.nvim_buf_call(buf, on_enter)
  return vim.notify("Current buffer history cleared.")
end
local function clear_all_histories()
  histories = {}
  for _, winid in pairs(vim.api.nvim_list_wins()) do
    vim.api.nvim_buf_call(vim.api.nvim_win_get_buf(winid), on_enter)
  end
  return vim.notify("All buffer histories cleared.")
end
local function delete_buffer(buf)
  local function confirm_save()
    local bufnm = path_utils["relative-path"](vim.fn.bufname())
    local ok, choice = pcall(vim.fn.confirm, ("Save changes to %q?"):format(bufnm), "&Yes\n&No\n&Cancel")
    local save_3f = (ok and (choice == 1))
    if save_3f then
      vim.cmd.write()
    else
    end
    return save_3f
  end
  local function confirm_save_modified()
    if vim.bo.modified then
      return confirm_save()
    else
      return true
    end
  end
  if not vim.api.nvim_buf_is_valid(buf) then
    return false
  elseif vim.api.nvim_buf_call(buf, confirm_save_modified) then
    pcall(vim.cmd, ("bwipeout! " .. tostring(buf)))
    return true
  else
    return false
  end
end
local function delete_all_invisible_buffers()
  local function delete_with_count()
    local count = 0
    for _, buf in pairs(vim.api.nvim_list_bufs()) do
      if (buffer_listed_3f(buf) and not buffer_visible_3f(buf) and delete_buffer(buf)) then
        count = (count + 1)
      else
        count = count
      end
    end
    return count
  end
  local count = delete_with_count()
  return vim.notify((tostring(count) .. " buffer(s) deleted"))
end
return {histories = histories, ["on-enter"] = on_enter, on_enter = on_enter, ["on-delete"] = on_delete, on_delete = on_delete, forward = forward, back = back, ["popup-select-menu"] = popup_select_menu, popup_select_menu = popup_select_menu, ["clear-curr-history"] = clear_curr_history, clear_curr_history = clear_curr_history, ["clear-all-histories"] = clear_all_histories, clear_all_histories = clear_all_histories, ["delete-buffer"] = delete_buffer, delete_buffer = delete_buffer, ["delete-all-invisible-buffers"] = delete_all_invisible_buffers, delete_all_invisible_buffers = delete_all_invisible_buffers}
