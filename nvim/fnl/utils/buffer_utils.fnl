;; Buffer history management functions
;; Copied from https://github.com/wilfreddenton/history.nvim and updated for my preference.

(import-macros m :my-macros)

(local path-utils (require :utils.path_utils))
(local popup-utils (require :utils.popup_utils))

;; File types to be ignored
(local IGNORES ["" :netrw :oil])

;; Max items in the list per window
(local MAX-ITEMS 12)

;; variable to store the current state of the buffer history, like
;; { <winid> {:index 1 ; index of the current buffer in bufs
;;            :bufs [{:nr <bufnr> :nm <bufnm>} ...]}}
(var histories {})

(fn buffer-listed? [buf]
  (-?> vim.bo
       (. buf)
       (. :buflisted)))

(fn buffer-visible? [buf]
  (accumulate [visible? false _ winid (ipairs (vim.api.nvim_list_wins))
               &until visible?]
    (= buf (vim.api.nvim_win_get_buf winid))))

(fn on-enter []
  (fn new-buffer-info [bufnr bufnm]
    (when (and (m.not-blank? bufnm) ;
               (not (m.has-value? IGNORES vim.bo.filetype)) ;
               (buffer-listed? bufnr))
      {:nr bufnr :nm bufnm}))

  (fn insert-buffer-to-history [buffer-info history]
    (let [buffers [buffer-info]] ; start with an array with only buffer-info
      (for [i history.index (length history.bufs) ; scan from current index in history
            &until (>= (length buffers) MAX-ITEMS)] ; limit # of items to MAX-ITEMS
        (let [buf (. history.bufs i)] ; insert to buffer list only when different from the current buffer
          (when (not= buffer-info.nr buf.nr)
            (table.insert buffers buf))))
      buffers))

  (fn new-buffer-list [buffer-info history]
    (if ;; If this is the first buffer for the window,
        ;; simply create a new history with the single buffer info.
        (m.nil? history)
        [buffer-info]
        ;; If the last buffer is same as this buffer, no updates in the history
        (= buffer-info.nr (. history.bufs history.index :nr))
        nil
        ;; else
        (insert-buffer-to-history buffer-info history)))

  (fn update-history [buffers winid]
    (tset histories winid {:index 1 :bufs buffers}))

  (let [bufnr (vim.api.nvim_get_current_buf)
        bufnm (path-utils.relative-path (vim.api.nvim_buf_get_name bufnr))
        winid (vim.api.nvim_get_current_win)
        history (. histories winid)]
    (-?> (new-buffer-info bufnr bufnm)
         (new-buffer-list history)
         (update-history winid))))

(fn on-delete []
  (fn find-index [bufnr history]
    (accumulate [result nil ;
                 index buf (ipairs history.bufs) ;
                 &until result]
      (when (= bufnr buf.nr) index)))

  (fn new-history [bufnr history]
    (let [target-index (find-index bufnr history)]
      (when target-index
        (let [buffers (icollect [i buf (ipairs history.bufs)]
                        (when (not= target-index i) buf))
              curr-index history.index
              new-index (if (< target-index curr-index) ;
                            (m.dec curr-index) ;
                            curr-index)]
          {:index new-index :bufs buffers}))))

  (let [bufnr (tonumber (vim.fn.expand :<abuf>))]
    (when (and bufnr (buffer-listed? bufnr))
      (each [winid history (pairs histories)]
        (tset histories winid (new-history bufnr history))))))

(fn forward []
  (let [winid (vim.api.nvim_get_current_win)
        h (. histories winid)]
    (when (and h (> h.index 1))
      (set h.index (m.dec h.index))
      (vim.api.nvim_set_current_buf (. h.bufs h.index :nr)))))

(fn back []
  (let [winid (vim.api.nvim_get_current_win)
        h (. histories winid)]
    (when (and h (< h.index (length h.bufs)))
      (set h.index (m.inc h.index))
      (vim.api.nvim_set_current_buf (. h.bufs h.index :nr)))))

(fn popup-select-menu []
  (fn create-menu-items [winid buffers]
    (icollect [i buf (ipairs buffers)]
      [buf.nm {: winid :index i}]))

  (fn create-callbacks [buffers]
    {:on_submit (fn [item]
                  (vim.api.nvim_set_current_buf (. buffers item.index :nr)))})

  (fn create-opts [index]
    {:width "80%" :focus_linenr index})

  (let [winid (vim.api.nvim_get_current_win)
        history (. histories winid)]
    (when (m.not-empty? history.bufs)
      (popup-utils.popup-menu "Buffer history" ; title
                              (create-menu-items winid history.bufs) ; menuitems
                              (create-callbacks history.bufs) ; callbacks
                              (create-opts history.index)))))

(fn clear-curr-history []
  (let [winid (vim.api.nvim_get_current_win)
        buf (vim.api.nvim_win_get_buf winid)]
    (tset histories winid nil)
    (vim.api.nvim_buf_call buf on-enter)
    (vim.notify "Current buffer history cleared.")))

(fn clear-all-histories []
  (set histories {})
  (each [_ winid (pairs (vim.api.nvim_list_wins))]
    (-> winid
        (vim.api.nvim_win_get_buf)
        (vim.api.nvim_buf_call on-enter)))
  (vim.notify "All buffer histories cleared."))

(fn delete-buffer [buf]
  (fn confirm-save []
    (let [bufnm (path-utils.relative-path (vim.fn.bufname))
          (ok choice) (pcall vim.fn.confirm ;
                             (: "Save changes to %q?" :format bufnm) ;
                             "&Yes\n&No\n&Cancel")
          save? (and ok (= choice 1))]
      (when save? (vim.cmd.write))
      save?))

  (fn confirm-save-modified []
    (if vim.bo.modified (confirm-save) true))

  (if (not (vim.api.nvim_buf_is_valid buf))
      false
      ;; get user confirmation to delete the buffer
      (vim.api.nvim_buf_call buf confirm-save-modified)
      (do
        (pcall vim.cmd (.. "bwipeout! " (tostring buf)))
        true)
      ;; else
      false))

(fn delete-all-invisible-buffers []
  (fn delete-with-count []
    (accumulate [count 0 _ buf (pairs (vim.api.nvim_list_bufs))]
      (if (and (buffer-listed? buf) ;
               (not (buffer-visible? buf)) ;
               (delete-buffer buf))
          (m.inc count)
          count)))

  (let [count (delete-with-count)]
    (vim.notify (.. (tostring count) " buffer(s) deleted"))))

{;
 : histories
 : on-enter
 :on_enter on-enter
 : on-delete
 :on_delete on-delete
 : forward
 : back
 : popup-select-menu
 :popup_select_menu popup-select-menu
 : clear-curr-history
 :clear_curr_history clear-curr-history
 : clear-all-histories
 :clear_all_histories clear-all-histories
 : delete-buffer
 :delete_buffer delete-buffer
 : delete-all-invisible-buffers
 :delete_all_invisible_buffers delete-all-invisible-buffers}
