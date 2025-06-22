;;; lisp/format.el -*- lexical-binding: t; -*-

;; Indent / Format buffer
(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))


;; map! with :leader will bind the key globally, so use evil-define-key with local map
;; TODO: which-key show it even in visual mode. fix it later.
(dolist (hook '(emacs-lisp-mode-hook lisp-mode-hook scheme-mode-hook))
  (add-hook hook
            (lambda ()
              (evil-define-key 'normal (current-local-map)
                (kbd "SPC b f") #'indent-buffer))))

