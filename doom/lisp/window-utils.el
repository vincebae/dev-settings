;;; ../myconfig/doom/lisp/window-utils.el -*- lexical-binding: t; -*-

(defvar my/default-horizontal-split-size 20
  "Default height of the horizontal split window")

(defvar my/default-vertical-split-size 80
  "Default width of the vertical split window")

(defun my/split-display-action (direction &optional size)
  "Create a display action to split window to the given direction with the size.
   valid directions: \='bottom, \='up, \='right, \='left"
  (let* ((size (or size my/default-horizontal-split-size))
         (dimension (cond
                       ((eql direction 'bottom) 'window-height)
                       ((eql direction 'up) 'window-height)
                       ((eql direction 'right) 'window-width)
                       ((eql direction 'left) 'window-width))))
    `((display-buffer-in-side-window)
      (side . ,direction)
      (,dimension . ,size))))

(defun my/open-buffer-window (buf direction &optional size)
  "Open a new buffer in split window.
   valid directions: \='bottom, \='up, \='right, \='left"
  (if-let ((win (get-buffer-window buf)))
      (select-window win)
    (let ((display-action (my/split-display-action direction size)))
      (select-window (display-buffer buf display-action)))))
