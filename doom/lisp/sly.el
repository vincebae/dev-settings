;;; ../myconfig/doom/lisp/sly.el -*- lexical-binding: t; -*-

(defvar my/sly-mrepl-horizontal-size 20
  "Height of the horizontal sly-mrepl window")

(defvar my/sly-mrepl-vertical-size 80
  "Width of the vertical sly-mrepl window")

(defun my/open-buffer-window (buf display-action)
  (if-let ((win (get-buffer-window buf)))
      (select-window win)
    (select-window (display-buffer buf display-action))))

(defun my/horizontal-split-display-action (&optional size)
  (let ((height(or size my/sly-mrepl-vertical-size)))
    `((display-buffer-in-side-window)
      (side . bottom)
      (window-width . ,height))))

(defun my/vertical-split-display-action (&optional size)
  (let ((width (or size my/sly-mrepl-vertical-size)))
    `((display-buffer-in-side-window)
      (side . right)
      (window-width . ,width))))

(defun my/open-sly-mrepl-horizontal ()
  (interactive)
  (my/open-buffer-window (sly-mrepl--find-create (sly-current-connection))
                         (my/horizontal-split-display-action)))

(defun my/open-sly-mrepl-vertical ()
  (interactive)
  (my/open-buffer-window (sly-mrepl--find-create (sly-current-connection))
                         (my/vertical-split-display-action)))

(defun my/open-sly-scratch-horizontal ()
  (interactive)
  (my/open-buffer-window (sly-scratch-buffer)
                         (my/horizontal-split-display-action)))

(defun my/open-sly-scratch-vertical ()
  (interactive)
  (my/open-buffer-window (sly-scratch-buffer)
                         (my/vertical-split-display-action)))

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
