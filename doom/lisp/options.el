;;; lisp/options.el -*- lexical-binding: t; -*-

;; Change localleader
(setq doom-localleader-key "")
(setq doom-localleader-alt-key "M-;")

;; Disable the "Really exit Emacs?" confirmation prompt
(setq confirm-kill-emacs nil)

;; Faster which-key
(after! which-key
  (setq which-key-idle-delay 0.1
        which-key-idle-secondary-delay 0.01))

;; line number: both absolute and relative
(setq display-line-numbers-type 'absolute)
(use-package! nlinum-relative
  :config
  (nlinum-relative-setup-evil)
  (add-hook 'prog-mode-hook 'nlinum-relative-mode))
