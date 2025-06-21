;;; ../myconfig/doom/lisp/quickfix.el -*- lexical-binding: t; -*-

;; Using embark like vim's quickfix list.

(defvar my/embark-export-buffer nil)

(defun my/save-embark-export-buffer ()
  (when (derived-mode-p 'occur-mode 'compilation-mode)
    (setq my/embark-export-buffer (current-buffer))))

(add-hook 'occur-mode-hook #'my/save-embark-export-buffer)
(add-hook 'compilation-mode-hook #'my/save-embark-export-buffer)

(defun my/close-embark-export-buffer ()
  (interactive)
  (when my/embark-export-buffer
      (delete-window (get-buffer-window my/embark-export-buffer))
      (setq my/embark-export-buffer nil)))

;; Keybindings
(map! :after evil
      :n "]q" #'next-error
      :n "[q" #'previous-error
      ;; TODO: make the embark export buffer toggleable
      :n "C-q" #'my/close-embark-export-buffer)

(after! evil
  (define-key minibuffer-local-map (kbd "C-q") #'embark-export))
