-- [nfnl] nvim/fnl/utils/popup_utils.fnl
local menu = require("nui.menu")
local DEFAULT_POPUP_OPTIONS = {position = "50%", border = {style = "single", text = {top_align = "center"}}, win_options = {winhighlight = "Normal:Normal,FloatBorder:Normal"}}
local DEFAULT_KEYMAP = {focus_next = {"j", "<Down>", "<Tab>"}, focus_prev = {"k", "<Up>", "<S-Tab>"}, close = {"<Esc>", "<C-c>", "q"}, submit = {"<CR>", "<Space>"}}
local function create_popup_options(title, _3fwidth)
  local opts = vim.deepcopy(DEFAULT_POPUP_OPTIONS, true)
  opts.border.text.top = title
  if _3fwidth then
    opts.size = {width = _3fwidth}
  else
  end
  return opts
end
local function create_menu_lines(menuitems)
  local function create_line(item)
    if (type(item) == "table") then
      return menu.item(item[1], (item[2] or {}))
    else
      return menu.item(item)
    end
  end
  local tbl_21_ = {}
  local i_22_ = 0
  for __7_auto, v_8_auto in ipairs(menuitems) do
    local val_23_ = create_line(v_8_auto)
    if (nil ~= val_23_) then
      i_22_ = (i_22_ + 1)
      tbl_21_[i_22_] = val_23_
    else
    end
  end
  return tbl_21_
end
local function create_menu(popup_options, lines, callbacks)
  return menu(popup_options, {lines = lines, keymap = DEFAULT_KEYMAP, on_submit = callbacks.on_submit, on_close = callbacks.on_cloase, on_change = callbacks.on_change})
end
local function focus_line(menu0, focus_linenr)
  local found_3f = false
  for linenr = focus_linenr, #menu0.tree:get_nodes() do
    if found_3f then break end
    local node, target_linenr = menu0.tree:get_node(linenr)
    if not menu0._.should_skip_item(node) then
      vim.api.nvim_win_set_cursor(menu0.winid, {target_linenr, 0})
      menu0._.on_change(node)
      found_3f = true
    else
      found_3f = nil
    end
  end
  return found_3f
end
local function popup_menu(title, menuitems, callbacks, _3fopts)
  local opts = (_3fopts or {})
  local popup_options = create_popup_options(title, opts.width)
  local lines = create_menu_lines(menuitems)
  local menu0 = create_menu(popup_options, lines, callbacks)
  menu0:mount()
  local and_5_ = opts.focus_linenr
  if and_5_ then
    local _6_ = opts.focus_linenr
    and_5_ = ((2 <= _6_) and (_6_ <= #lines))
  end
  if and_5_ then
    focus_line(menu0, opts.focus_linenr)
  else
  end
  return vim.api.nvim_buf_set_keymap(menu0.bufnr, "n", "-", "<Nop>", {noremap = true, silent = true})
end
return {["popup-menu"] = popup_menu, popup_menu = popup_menu}
