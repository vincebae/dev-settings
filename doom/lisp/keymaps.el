;;; lisp/keymaps.el -*- lexical-binding: t; -*-

;; Change localleader
(setq doom-localleader-key ";")
(setq doom-localleader-alt-key "M-;")

;; emacs-lisp override "d" binding, so revive it.
(map! :after elisp-mode
      :map emacs-lisp-mode-map
      :nv "d" #'evil-delete)

;; Disable some org-mode bindings, too
(after! evil-org
  (evil-org-set-key-theme '(textobjects insert navigation)))

;; Faster window management
(use-package! tmux-pane
  :config
  (tmux-pane-mode)
  (map! :nv "C-h" #'tmux-pane-omni-window-left
        :nv "C-j" #'tmux-pane-omni-window-down
        :nv "C-k" #'tmux-pane-omni-window-up
        :nv "C-l" #'tmux-pane-omni-window-right))

(global-unset-key (kbd "C-s"))
(map! :after evil
      :nv "C-s" #'evil-window-split
      :nv "C-v" #'evil-window-vsplit)

;; Nvim oil-like key binding
(map! :after evil
      :n "-" #'dired-jump)

;; Remap find files key bindings
(map! :after evil
      :leader
      :desc "Search in current dir"
      :n "." (lambda ()
               (interactive)
               (consult-ripgrep default-directory)))

(map! :after evil
      :leader

      :desc "Find file from here"
      :n "f f" (lambda ()
                 (interactive)
                 (consult-find default-directory)))

(map! :after evil
      :leader
      :desc "Find file"
      :n "f F" #'find-file)

;; Rebind avy - leap like search and move
(map! :after evil
      :n "g /" #'evil-avy-goto-char-2)

;; bookmark
(map! :after evil
      :leader
      :desc "List Bookmarks"
      :n "RET" #'list-bookmarks)

(map! :after evil
      :n "m" #'bookmark-set)

;; Jump forward, since C-i doesn't work in emacs...
(map! :after evil
      :n "C-p" #'evil-jump-forward)

;; convenient key mappings
;; recenter after jump
(map! :after evil
      :n "n" (lambda () (interactive) (evil-ex-search-next) (recenter))
      :n "N" (lambda () (interactive) (evil-ex-search-previous) (recenter))
      :n "C-u" (lambda () (interactive) (evil-scroll-up nil) (recenter))
      :n "C-d" (lambda () (interactive) (evil-scroll-down nil) (recenter)))

;; Abbreviate ex commands like in Vim
(after! evil
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
