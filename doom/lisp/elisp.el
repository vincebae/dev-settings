;;; ../myconfig/doom/lisp/elisp.el -*- lexical-binding: t; -*-

(defvar my/scratch-buffer-name "*scratch*")

(defvar my/elisp-scratch-horizontal-size 20
  "Height of the horizontal sly-mrepl window")

(defvar my/elisp-scratch-vertical-size 80
  "Width of the vertical sly-mrepl window")

(defun my/eval-region (beg end)
  "Evaluate the region and overlay the result like other eros commands."
  (interactive "r")
  (let* ((region (buffer-substring-no-properties beg end))
         (result (eval (read region))))
    (setq eros--last-result result)
    (when (get-buffer eros--inspect-buffer-name)
      (eros-inspect-last-result))
    (eros--eval-overlay result end)))

(defun my/open-elisp-scratch-horizontal ()
  (interactive)
  (let ((buf (get-buffer my/scratch-buffer-name)))
    (my/open-buffer-window buf 'bottom my/elisp-scratch-horizontal-size)
    (lisp-interaction-mode)))

(defun my/open-elisp-scratch-vertical ()
  (interactive)
  (let ((buf (get-buffer my/scratch-buffer-name)))
    (my/open-buffer-window buf 'right my/elisp-scratch-vertical-size)
    (lisp-interaction-mode)))

(defun my/open-elisp-scratch-here ()
  (interactive)
  (scratch-buffer)
  (lisp-interaction-mode))

(after! elisp-mode
  (map! :localleader
        :map (emacs-lisp-mode-map lisp-interaction-mode-map)
        :desc "Eval region" :v "E" #'my/eval-region
        (:prefix ("e" . "eval")
         :desc "Eval top level" :n "r" #'eros-eval-defun
         :desc "Eval expression" :n ":" #'pp-eval-expression
         :desc "Open scratch horizontal" :n "s" #'my/open-elisp-scratch-horizontal
         :desc "Open scratch vertical" :n "v" #'my/open-elisp-scratch-vertical
         :desc "Open scratch here" :n "n" #'my/open-elisp-scratch-here)))
