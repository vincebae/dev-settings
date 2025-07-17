;;; Mark management functions

(import-macros m :my-macros)

(fn get-mark-label [mark]
  (mark.mark:sub 2 2))

(fn create-quickfix-item [filename pos label]
  (let [lnum (when (m.pos? (. pos 2)) (. pos 2))
        col (when (m.pos? (. pos 3)) (. pos 3))
        text (.. "mark " label)]
    {: filename : lnum : col : text}))

(fn open-quickfix-window [title items]
  (vim.fn.setqflist {} " " {: title : items})
  (vim.cmd :copen))

(fn buffer-marks-qf-items []
  (let [buffer (vim.api.nvim_get_current_buf)
        buffer-name (vim.api.nvim_buf_get_name buffer)
        marks (vim.fn.getmarklist buffer)]
    (icollect [_ mark (ipairs marks)]
      (let [label (get-mark-label mark)]
        ;; filter only lower case alphabet marks
        (when (string.match label "^[a-z]$")
          (create-quickfix-item buffer-name mark.pos label))))))

(fn global-marks-qf-items []
  (let [marks (vim.fn.getmarklist)]
    (icollect [_ mark (ipairs marks)]
      (let [filename mark.file
            label (get-mark-label mark)]
        ;; filter only upper case alphabet marks
        (when (and (m.not-blank? filename) (string.match label "^[A-Z]$"))
          (create-quickfix-item filename mark.pos label))))))

(fn open-buffer-marks-qf []
  (open-quickfix-window "Buffer Marks" (buffer-marks-qf-items)))

(fn open-global-marks-qf []
  (open-quickfix-window "Global Marks" (global-marks-qf-items)))

{;
 : open-buffer-marks-qf
 :open_buffer_marks_qf open-buffer-marks-qf
 : open-global-marks-qf
 :open_global_marks_qf open-global-marks-qf}
