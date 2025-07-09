;; [nfnl-macro]
;; This is not actually a macro, but above will prevent this file being compiled to lua.

{:libraries {:nvim true}
 :extra-globals "Snacks"
 :fennel-path "./?.fnl;./?/init.fnl;./fnl/?.fnl;./fnl/init.fnl;nvim/fnl/?.fnl;nvim/fnl/?/init.fnl"
 :macro-path "./?.fnl;./?/init-macros.fnl;./?/init.fnl;./fnl/?.fnl;./fnl/init-macros.fnl/nvim/fnl/?.fnl;nvim/fnl/?/init-macros.fnl;/?/init.fnl"}
