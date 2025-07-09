(import-macros m :my-macros)

(local pp (require :plenary.path))

(fn remove-oil-prefix [path]
  (m.cond-> path (m.starts-with? path "oil://") (string.sub 7)))

(fn get-buffer-path []
  (remove-oil-prefix (vim.fn.expand "%:p")))

(fn get-buffer-dir-path []
  (remove-oil-prefix (vim.fn.expand "%:p:h")))

(fn get-buffer-filename []
  (vim.fn.expand "%:t"))

(fn filename [path]
  (m.last (vim.fn.split path "/")))

(fn oil-filename []
  (let [line (vim.api.nvim_get_current_line)
        name (string.match line ".*  (.*)")]
    (if name
        (.. (get-buffer-dir-path) "/" name) "")))

(fn exists? [path]
  (-> path pp:new (: :exists)))

(fn dir? [path]
  (-> path pp:new (: :is_dir)))

(fn parent [path]
  (-> path pp:new (: :parent) (: :absolute)))

(fn relative-path [?path ?cwd]
  (let [path (or ?path (get-buffer-path))
        cwd (or ?cwd (vim.fn.getcwd))]
    (-> path pp:new (: :make_relative cwd))))

(fn create-directories [path]
  "Create directories recursively for the given path."
  (-> path
      pp:new
      (: :mkdir {:parents true :exists_ok true})))

(fn touch [path]
  "Touch the file for the given path only when the file doesn't already exist.
  Also, create parent directories if necessary."
  (let [plenary-path (pp:new path)]
    (when (not (plenary-path:exists))
      (-> plenary-path (: :parent) (: :mkdir {:parents true :exists_ok true}))
      (plenary-path:touch))))

{;;
 : remove-oil-prefix
 :remove_oil_prefix remove-oil-prefix
 : get-buffer-path
 :get_buffer_path get-buffer-path
 : get-buffer-dir-path
 :get_buffer_dir_path get-buffer-dir-path
 : get-buffer-filename
 :get_buffer_filename get-buffer-filename
 : filename
 : oil-filename
 :oil_filename oil-filename
 : exists?
 :exists exists?
 : dir?
 :is_dir dir?
 : parent
 : relative-path
 :relative_path relative-path
 : create-directories
 :create_directories create-directories
 : touch}
