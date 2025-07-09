(import-macros m :my-macros)

(local pu (require :utils.path_utils))

(fn get-namespace []
  (fn path->namespace [path]
    (-> path
        (string.gsub "/" ".")
        (string.gsub "_" "-")))

  (let [path (pu.relative_path)
        src-path (string.match path "src/(.*)[.]clj")
        test-path (string.match path "test/(.*)[.]clj")]
    (if src-path (path->namespace src-path)
        test-path (path->namespace test-path)
        "")))

(fn get-test-namespace []
  (local test-namespace-suffix :-test)
  (let [name (get-namespace)]
    (m.cond-> name (not (m.ends-with? name test-namespace-suffix))
              (.. test-namespace-suffix))))

(fn eval-buf-and-command [command]
  (let [filename (pu.relative-path)
        load-file-command (.. "(load-file \"" filename "\")")
        eval-command (.. "ConjureEval (do " load-file-command " " command ")")]
    (vim.cmd eval-command)))

(fn reload-namespace []
  (let [namespace (get-namespace)
        command (.. "(require '" namespace " :reload-all)")]
    (eval-buf-and-command command)))

(fn into-namespace []
  (let [namespace (get-namespace)
        command (.. "(in-ns '" namespace ")")]
    (eval-buf-and-command command)))

(fn test-namespace []
  (let [namespace (get-namespace)
        command (.. "(clojure.test/run-tests '" namespace ")")]
    (eval-buf-and-command command)))

(fn nrepl-server-command []
  "clj -Sdeps '{:deps {nrepl/nrepl {:mvn/version \"1.3.1\"}}}' -M -m nrepl.cmdline")

(fn start-nrepl-server []
  (let [toggleterm (require :toggleterm)]
    (toggleterm.exec (nrepl-server-command) ;; num
                     20 ;; size
                     "." ;; dir
                     :horizontal :nREPL-Server true ;; go_back
                     false)
    ;; open
    (vim.notify "Starting Clojure nREPL server starting...")))

(fn doc-str []
  (let [expr (vim.fn.input "Symbol > ")]
    (when (m.not-blank? expr)
      (vim.cmd (.. "ConjureEval (clojure.repl/doc " expr ")")))))

{;;
 : get-namespace
 :get_namespace get-namespace
 : get-test-namespace
 :get_test_namespace get-test-namespace
 : eval-buf-and-command
 :eval_buf_and_command eval-buf-and-command
 : reload-namespace
 :reload_namespace reload-namespace
 : into-namespace
 :into_namespace into-namespace
 : test-namespace
 :test_namespace test-namespace
 : nrepl-server-command
 :nrepl_server_command nrepl-server-command
 : start-nrepl-server
 :start_nrepl_server start-nrepl-server
 : doc-str
 :doc_str doc-str}
