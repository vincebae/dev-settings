;;; lisp/keymaps.el -*- lexical-binding: t; -*-

;; emacs-lisp override "d" binding, so revive it.
(after! elisp-mode
  (map! :map emacs-lisp-mode-map
        :nv "d" #'evil-delete))

;; Faster window management
(use-package! tmux-pane
  :config
  (tmux-pane-mode)
  (map! :nv "C-h" #'tmux-pane-omni-window-left
        :nv "C-j" #'tmux-pane-omni-window-down
        :nv "C-k" #'tmux-pane-omni-window-up
        :nv "C-l" #'tmux-pane-omni-window-right))

(global-unset-key (kbd "C-s"))
(map! :nv "C-s" #'evil-window-split
      :nv "C-v" #'evil-window-vsplit)

;; Nvim oil-like key binding
(after! dired
  (map! :n "-" #'dired-jump))

;; convenient key mappings
(after! evil
  ;; recenter after jump
  (map!
   :n "n" (lambda () (interactive) (evil-ex-search-next) (recenter))
   :n "N" (lambda () (interactive) (evil-ex-search-previous) (recenter))
   :n "C-u" (lambda () (interactive) (evil-scroll-up nil) (recenter))
   :n "C-d" (lambda () (interactive) (evil-scroll-down nil) (recenter)))

  ;; Abbreviate ex commands like in Vim
  (evil-ex-define-cmd "W" "w")
  (evil-ex-define-cmd "W!" "w!")
  (evil-ex-define-cmd "Wq" "wq")
  (evil-ex-define-cmd "Wa" "wa")
  (evil-ex-define-cmd "wQ" "wq")
  (evil-ex-define-cmd "Q" "q")
  (evil-ex-define-cmd "Q!" "q!")
  (evil-ex-define-cmd "Qa" "qa")
  (evil-ex-define-cmd "Qa!" "qa!")
  (evil-ex-define-cmd "Qall" "qall")
  (evil-ex-define-cmd "Qall!" "qall!"))
