;;; ../myconfig/doom/lisp/sly.el -*- lexical-binding: t; -*-

(load! "window-utils.el")

(defvar my/sly-split-horizontal-size 20
  "Height of the horizontal sly-mrepl window")

(defvar my/sly-split-vertical-size 80
  "Width of the vertical sly-mrepl window")

(defun my/open-sly-mrepl-horizontal ()
  (interactive)
  (let ((buf (sly-mrepl--find-create (sly-current-connection))))
   (my/open-buffer-window buf 'bottom my/sly-split-horizontal-size)))

(defun my/open-sly-mrepl-vertical ()
  (interactive)
  (let ((buf (sly-mrepl--find-create (sly-current-connection))))
   (my/open-buffer-window buf 'right my/sly-split-vertical-size)))

(defun my/open-sly-scratch-horizontal ()
  (interactive)
  (let ((buf (sly-scratch-buffer)))
   (my/open-buffer-window buf 'bottom my/sly-split-horizontal-size)))

(defun my/open-sly-scratch-vertical ()
  (interactive)
  (let ((buf (sly-scratch-buffer)))
   (my/open-buffer-window buf 'right my/sly-split-vertical-size)))

(defun my/sly-eval-string-from-minibuffer ()
  (interactive)
  (let ((lisp-string (read-string "Lisp expression to evaluate: ")))
      (sly-interactive-eval lisp-string)))

(after! lisp-mode
  (require 'sly)

  (map! :localleader
        :map lisp-mode-map
        :desc "Sync REPL"
        :g "r S" #'sly-mrepl-sync)

  (map! :localleader
        :map lisp-mode-map
        :desc "Open REPL horizontal"
        :g "r s" #'my/open-sly-mrepl-horizontal)

  ;; TODO: This currently doesn't work. fix it later
  (map! :localleader
        :map lisp-mode-map
        :desc "Open REPL vertical"
        :g "r v" #'my/open-sly-mrepl-vertical)

  (map! :localleader
        :map lisp-mode-map
        :desc "Open REPL current"
        :g "r n" #'sly-mrepl)

  (map! :localleader
        :map lisp-mode-map
        :desc "Open Scratch horizontal"
        :g "e s" #'my/open-sly-scratch-horizontal)

  (map! :localleader
        :map lisp-mode-map
        :desc "Open Scratch vertical"
        :g "e v" #'my/open-sly-scratch-vertical)

  (map! :localleader
        :map lisp-mode-map
        :desc "Evalute region"
        :v "E" #'sly-eval-region)

  (map! :localleader
        :map lisp-mode-map
        :desc "Evaluate from input"
        :n "e :" #'my/sly-eval-string-from-minibuffer)

  (map! :localleader
        :map lisp-mode-map
        :desc "Evalute top-level"
        :n "e r" #'sly-overlay-eval-defun))
