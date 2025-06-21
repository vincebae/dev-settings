;;; lisp/theme.el -*- lexical-binding: t; -*-

(defvar my-random-themes
  '(doom-tokyo-night
    jbeans
    wombat
    doom-one
    doom-1337
    doom-nord
    doom-nova
    doom-henna
    doom-opera
    doom-badger
    doom-Iosvkem
    doom-gruvbox
    doom-lantern
    doom-vibrant
    doom-peacock
    doom-ayu-dark
    doom-ayu-light
    doom-ir-black
    doom-material
    doom-molokai
    doom-old-hope
    doom-laserwave
    modus-vivendi
    doom-monokai-pro
    doom-nord-aurora
    doom-opera-light
    doom-feather-dark
    doom-oceanic-next
    doom-tomorrow-night
    doom-challenger-deep
    doom-monokai-spectrum
    solarized-wombat-dark
    doom-monokai-ristretto
    doom-winter-is-comming-light)
  "A list of themes to randomize for my setup.")

(defun my/randomize-theme ()
  (interactive)
  (let ((theme (nth (random (length my-random-themes)) my-random-themes)))
    (message "Setting random theme to: %s" theme)
    (load-theme theme t)))

(add-hook 'after-init-hook #'my/randomize-theme)
