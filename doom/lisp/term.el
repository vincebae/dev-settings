;;; ../myconfig/doom/lisp/term.el -*- lexical-binding: t; -*-

(defvar my/vterm-buffer-name "*my-vterm-buffer*"
  "The name of the single, persistent vterm buffer for splits.")

(defvar my/vterm-horizontal-size 20
  "Height of the horizontal vterm window")

(defvar my/vterm-vertical-size 80
  "Width of the vertical vterm window")

(defun my/protect-persistent-vterm-from-kill ()
  "A gatekeeper function to prevent the persistent vterm buffer from being killed."
  (if (and (boundp 'my/vterm-buffer-name)
           (equal (buffer-name) my/vterm-buffer-name))
      nil
    t))
(add-to-list 'kill-buffer-query-functions #'my/protect-persistent-vterm-from-kill)

(defun my/get-or-create-persistent-vterm ()
  "Return the persistent vterm buffer, creating it if it doesn't exist."
  (or (get-buffer my/vterm-buffer-name)
      (with-current-buffer (generate-new-buffer my/vterm-buffer-name)
        (vterm-mode)
        (current-buffer))))

(defun my/show-persistent-vterm (display-action)
  "A generic function to show the persistent vterm using a precise display-buffer action."
  (let ((buf (my/get-or-create-persistent-vterm)))
    (if-let ((win (get-buffer-window buf)))
        (select-window win)
      (select-window (display-buffer buf display-action)))))

(defun my/vertical-vterm ()
  "Show the persistent vterm in a vertical split."
  (interactive)
  (my/show-persistent-vterm
   `((display-buffer-in-side-window)
     (side . right)
     (window-width . ,my/vterm-vertical-size))))

(defun my/horizontal-vterm ()
  "Show the persistent vterm in a horizontal split."
  (interactive)
  (my/show-persistent-vterm
   `((display-buffer-in-side-window)
     (side . bottom)
     (window-height . ,my/vterm-horizontal-size))))

(defun my/hide-vterm-window ()
  "Hide the window containing the persistent vterm buffer without killing it."
  (interactive)
  (let ((win (get-buffer-window my/vterm-buffer-name)))
    (when win
      (delete-window win))))

(defun my/vterm-bind-keys ()
  (define-key vterm-mode-map (kbd "C-t") #'my/hide-vterm-window))

(add-hook 'vterm-mode-hook #'my/vterm-bind-keys)

;; Unbind Doom's new workspace key binding (C-t)
(after! evil
  (define-key evil-normal-state-map (kbd "C-t") nil))

;; Unbind sly mode key binding (C-t)
(add-hook 'sly-mode-hook
          (lambda () (evil-define-key 'normal sly-mode-map (kbd "C-t") nil)))

(add-hook 'sly-popup-buffer-mode-hook
          (lambda () (evil-define-key 'normal sly-popup-buffer-mode-map (kbd "C-t") nil)))

;; Map terminal keys
(after! evil
  (map! :prefix "C-t"
        :desc "Vertical vterm"
        :g "v" #'my/vertical-vterm
        :desc "Horizontal vterm"
        :g "s" #'my/horizontal-vterm
        :desc "Close vterm"
        :g "c" #'my/hide-vterm-window))
