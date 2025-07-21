(import-macros m :my-macros)

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

(fn regular-file? [path]
  (= (vim.fn.filereadable path) 1))

(fn dir? [path]
  (= (vim.fn.isdirectory path) 1))

(fn exists? [path]
  (or (regular-file? path) (dir? path)))

(fn parent [path]
  (path:match "(.*)/"))

(fn relative-path [?path ?cwd]
  "Returns relative path of ?path against ?cwd
  If ?path is not specified, path of the current buffer is used.
  If ?cwd is not specified, path of the current working directory is used."
  (fn with-separator [p]
    (let [len (length p)
          last-char (p:sub len)]
      (m.cond-> p (not= last-char "/") (.. "/"))))

  (let [path (or ?path (get-buffer-path))
        path-with-sep (with-separator path)
        cwd (or ?cwd (vim.fn.getcwd))
        cwd-with-sep (with-separator cwd)]
    (if ;; path is self.
        (= path-with-sep cwd-with-sep) ;
        "." ;
        ;; path is a decendant of cwd
        (m.starts-with? path cwd-with-sep) ;
        (path:sub (m.inc (length cwd-with-sep)) -1) ;
        ;; else
        path)))

(fn create-directories [path]
  "Create directories recursively for the given path."
  (vim.fn.mkdir path :p))

(fn touch [path]
  "Touch the file for the given path only when the file doesn't already exist.
  Also, create parent directories if necessary."
  (fn touch-internal []
    (create-directories (parent path))
    (let [file (io.open path :a)]
      (if file
          (do
            (file:close)
            (vim.notify (.. "File '" path "' touched.")))
          (vim.notify (.. "Error: Could not touch file '" path "'.")
                      vim.log.levels.ERROR))))

  (if (not (exists? path))
      (touch-internal path)
      (vim.notify (.. "File '" path "' already exists.") vim.log.levels.WARN)))

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
 : regular-file?
 :is_regular_file regular-file?
 : dir?
 :is_dir dir?
 : exists?
 :exists exists?
 : parent
 : relative-path
 :relative_path relative-path
 : create-directories
 :create_directories create-directories
 : touch}
