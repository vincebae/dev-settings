(import-macros m :my-macros)

(local pu (require :utils.path_utils))
(local su (require :utils.string_utils))
(local toggleterm (require :toggleterm))
(local ts-utils (require :nvim-treesitter.ts_utils))

(fn get-package-name []
  (or (-?> (pu.get-buffer-dir-path)
           (string.match ".*/src/%a+/java/(.*)")
           (string.gsub "/" ".")) ""))

(fn get-class-name []
  (-> (pu.get-buffer-filename)
      (string.gsub :.java$ "")))

(fn get-test-class-name []
  (let [name (get-class-name)]
    (if (m.ends-with? name :Test)
        name
        (.. name :Test))))

(fn get-current-method-name []
  (fn get-method-identifier [node]
    (when (= (node:type) :method_declaration)
      (accumulate [identifier nil child _ (node:iter_children) &until identifier]
        (when (= (child:type) :identifier)
          (vim.treesitter.get_node_text child (vim.fn.bufnr))))))

  (var name nil)
  (var node (ts-utils.get_node_at_cursor 0 true))
  (while (and (m.nil? name) node)
    (set name (get-method-identifier node))
    (set node (node:parent)))
  (or name ""))

(fn run-test [test-name opts]
  (fn send-to-terminal [cmd]
    (toggleterm.exec cmd 1 20 "." :horizontal))

  (fn send-to-slime [cmd]
    (vim.cmd (.. "SlimeSend0 " (su.make_literal (.. cmd "\n")))))

  (m.cond-> "./gradlew test --rerun" ;
            (m.not-blank? test-name) (.. " --tests " test-name) ;
            opts.debug (.. " --debug-jvm") ;
            (= opts.env :terminal) (send-to-terminal) ;
            (= opts.env :slime) (send-to-slime)))

(fn run-test-all [opts]
  (run-test "" opts))

(fn run-test-class [opts]
  (run-test (get-test-class-name) opts))

(fn run-test-method [opts]
  (let [method-name (vim.fn.input "Method:" (get-current-method-name))]
    (when (m.not-blank? method-name)
      (let [test-name (.. (get-package-name) "." (get-test-class-name) "."
                          method-name)]
        (run-test test-name opts)))))

{;
 : get-package-name
 :get_package_name get-package-name
 : get-class-name
 :get_class_name get-class-name
 : get-test-class-name
 :get_test_class_name get-test-class-name
 : get-current-method-name
 :get_current_method_name get-current-method-name
 : run-test
 :run_test run-test
 : run-test-all
 :run_test_all run-test-all
 : run-test-class
 :run_test_class run-test-class
 : run-test-method
 :run_test_method run-test-method}
