(import-macros m :my-macros)

(local path-utils (require :utils.path_utils))
(local popup-utils (require :utils.popup_utils))

(local TOGGLE-TEST-OPTS
       {:java {:main-dir-pattern :/src/main/
               :test-dir-pattern :/src/test/
               :file-extension :java
               :test-file-suffix :Test}
        :clojure {:main-dir-pattern :/src/
                  :test-dir-pattern :/test/
                  :file-extension :clj
                  :test-file-suffix :_test}})

(var project-type nil)

(fn popup-create-menu [path dir?]
  (fn on-submit-fn [item]
    (case item.id
      :1 (do
           (if dir?
               (path-utils.create-directories path)
               (path-utils.touch path))
           (vim.cmd (.. "e " path)))
      :2 (let [parent-path (path-utils.parent path)]
           (path-utils.create-directories parent-path)
           (vim.cmd (.. "e " parent-path)))))

  (let [title (.. (path-utils.filename path) " doesn't exist.")
        menuitems [["Create the file" {:id :1}]
                   ["Open parent (create if necessary)" {:id :2}]
                   ["Do nothing" {:id :3}]]
        callbacks {:on_submit on-submit-fn}]
    (popup-utils.popup_menu title menuitems callbacks)))

(fn popup-project-type-menu [callback-fn]
  (fn on-submit-fn [item]
    (set project-type item.text)
    (callback-fn))

  (let [title "Choose project type:"
        menuitems (m.keys TOGGLE-TEST-OPTS)
        callbacks {:on_submit on-submit-fn}]
    (popup-utils.popup_menu title menuitems callbacks)))

(fn open-path [path ?opts]
  (when path
    (let [opts (or ?opts {})]
      (if (path-utils.exists path) (vim.cmd (.. "e " path))
          opts.prompt-if-not-exist (popup-create-menu path opts.dir?)))))

(fn get-toggle-dir-path [path opts]
  (if (string.find path opts.main-dir-pattern)
      (string.gsub path opts.main-dir-pattern opts.test-dir-patterh)
      (string.find path opts.test-dir-pattern)
      (string.gsub path opts.test-dir-pattern opts.main-dir-pattern)))

(fn get-toggle-file-path [path opts]
  (let [main-file-pattern (string.format "%s(.+)[.]%s$" opts.main-dir-pattern
                                         opts.file-extension)
        test-file-pattern (string.format "%s(.+)%s[.]%s$" opts.test-dir-pattern
                                         opts.test-file-suffix
                                         opts.file-extension)]
    (if (string.find path main-file-pattern)
        (let [test-file-replace-pattern (string.format "%s%%1%s.%s"
                                                       opts.test-dir-pattern
                                                       opts.test-file-suffix
                                                       opts.file-extension)]
          (string.gsub path main-file-pattern test-file-replace-pattern))
        (string.find path test-file-pattern)
        (let [main-file-replace-pattern (string.format "%s%%1.%s"
                                                       opts.main-dir-pattern
                                                       opts.file-extension)]
          (string.gsub path test-file-pattern main-file-replace-pattern)))))

(fn get-toggle-path [path dir? opts]
  (if dir?
      (get-toggle-dir-path path opts)
      (get-toggle-file-path path opts)))

(fn get-toggle-test-opts []
  (or (. TOGGLE-TEST-OPTS project-type)
      (let [filetype vim.bo.filetype
            opts (. TOGGLE-TEST-OPTS filetype)]
        (when opts
          (set project-type filetype)
          opts))))

(fn toggle-test []
  (let [opts (get-toggle-test-opts)]
    (if (m.nil? opts)
        (popup-project-type-menu toggle-test)
        (let [path (path-utils.get-buffer-path)
              dir? (path-utils.dir? path)
              toggle-path (get-toggle-path path dir? opts)]
          (open-path toggle-path {:prompt-if-not-exist true : dir?})))))

{;
 : toggle-test
 :toggle_test toggle-test}
