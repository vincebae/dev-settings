;; Download quicklisp.lisp by
;; $ curl -O https://beta.quicklisp.org/quicklisp.lisp

(load "quicklisp.lisp")
(quicklisp-quickstart:install)
(ql:system-apropos "vecto")
(ql:quickload "vecto")
(ql:add-to-init-file)
(quit)
