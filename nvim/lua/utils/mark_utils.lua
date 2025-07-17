-- [nfnl] nvim/fnl/utils/mark_utils.fnl
local function get_mark_label(mark)
  return mark.mark:sub(2, 2)
end
local function create_quickfix_item(filename, pos, label)
  local lnum
  if (pos[2] > 0) then
    lnum = pos[2]
  else
    lnum = nil
  end
  local col
  if (pos[3] > 0) then
    col = pos[3]
  else
    col = nil
  end
  local text = ("mark " .. label)
  return {filename = filename, lnum = lnum, col = col, text = text}
end
local function open_quickfix_window(title, items)
  vim.fn.setqflist({}, " ", {title = title, items = items})
  return vim.cmd("copen")
end
local function buffer_marks_qf_items()
  local buffer = vim.api.nvim_get_current_buf()
  local buffer_name = vim.api.nvim_buf_get_name(buffer)
  local marks = vim.fn.getmarklist(buffer)
  local tbl_21_ = {}
  local i_22_ = 0
  for _, mark in ipairs(marks) do
    local val_23_
    do
      local label = get_mark_label(mark)
      if string.match(label, "^[a-z]$") then
        val_23_ = create_quickfix_item(buffer_name, mark.pos, label)
      else
        val_23_ = nil
      end
    end
    if (nil ~= val_23_) then
      i_22_ = (i_22_ + 1)
      tbl_21_[i_22_] = val_23_
    else
    end
  end
  return tbl_21_
end
local function global_marks_qf_items()
  local marks = vim.fn.getmarklist()
  local tbl_21_ = {}
  local i_22_ = 0
  for _, mark in ipairs(marks) do
    local val_23_
    do
      local filename = mark.file
      local label = get_mark_label(mark)
      local _5_
      do
        local s_19_auto = filename
        _5_ = (s_19_auto and (s_19_auto ~= ""))
      end
      if (_5_ and string.match(label, "^[A-Z]$")) then
        val_23_ = create_quickfix_item(filename, mark.pos, label)
      else
        val_23_ = nil
      end
    end
    if (nil ~= val_23_) then
      i_22_ = (i_22_ + 1)
      tbl_21_[i_22_] = val_23_
    else
    end
  end
  return tbl_21_
end
local function open_buffer_marks_qf()
  return open_quickfix_window("Buffer Marks", buffer_marks_qf_items())
end
local function open_global_marks_qf()
  return open_quickfix_window("Global Marks", global_marks_qf_items())
end
return {["open-buffer-marks-qf"] = open_buffer_marks_qf, open_buffer_marks_qf = open_buffer_marks_qf, ["open-global-marks-qf"] = open_global_marks_qf, open_global_marks_qf = open_global_marks_qf}
