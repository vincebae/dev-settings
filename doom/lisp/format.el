;;; lisp/format.el -*- lexical-binding: t; -*-

;; Indent / Format buffer
(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(map! :map emacs-lisp-mode-map
      :leader
      :desc "Format elisp buffer"
      "b f" #'indent-buffer)
