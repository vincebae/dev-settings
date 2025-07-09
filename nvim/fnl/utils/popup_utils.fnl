(import-macros m :my-macros)

(local menu (require :nui.menu))

(local DEFAULT-POPUP-OPTIONS
       {:position "50%"
        :border {:style :single :text {:top_align :center}}
        :win_options {:winhighlight "Normal:Normal,FloatBorder:Normal"}})

(local DEFAULT-KEYMAP {:focus_next [:j :<Down> :<Tab>]
                       :focus_prev [:k :<Up> :<S-Tab>]
                       :close [:<Esc> :<C-c> :q]
                       :submit [:<CR> :<Space>]})

(fn create-popup-options [title ?width]
  (let [opts (vim.deepcopy DEFAULT-POPUP-OPTIONS true)]
    (set opts.border.text.top title)
    (when ?width
      (set opts.size {:width ?width}))
    opts))

(fn create-menu-lines [menuitems]
  (fn create-line [item]
    (if (= (type item) :table)
        (menu.item (m.first item) (or (m.second item) {}))
        (menu.item item)))

  (m.map create-line menuitems))

(fn create-menu [popup-options lines callbacks]
  (menu popup-options {: lines
                       :keymap DEFAULT-KEYMAP
                       :on_submit callbacks.on_submit
                       :on_close callbacks.on_cloase
                       :on_change callbacks.on_change}))

(fn focus-line [menu focus-linenr]
  (faccumulate [found? false linenr focus-linenr (length (menu.tree:get_nodes))
                &until found?]
    (let [(node target-linenr) (menu.tree:get_node linenr)]
      (when (not (menu._.should_skip_item node))
        (vim.api.nvim_win_set_cursor menu.winid [target-linenr 0])
        (menu._.on_change node)
        true))))

(fn popup-menu [title menuitems callbacks ?opts]
  (let [opts (or ?opts {})
        popup-options (create-popup-options title opts.width)
        lines (create-menu-lines menuitems)
        menu (create-menu popup-options lines callbacks)]
    (menu:mount)
    (when (and opts.focus_linenr (<= 2 opts.focus_linenr (length lines)))
      (focus-line menu opts.focus_linenr))
    ;; disable "-" key for oil
    (vim.api.nvim_buf_set_keymap menu.bufnr :n "-" :<Nop>
                                 {:noremap true :silent true})))

{;
 : popup-menu
 :popup_menu popup-menu}
