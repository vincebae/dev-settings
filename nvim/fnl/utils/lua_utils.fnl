(local pu (require :utils.path_utils))

(fn get-package-name-helper [path file-type]
  (let [file-pattern (case file-type
                       :lua ".*/lua/(.*).lua$"
                       :fnl ".*/fnl/(.*).fnl$")
        extracted (string.match path file-pattern)]
    (when extracted (string.gsub extracted "/" "."))))

(fn get-package-name []
  (let [path (pu.get_buffer_path)]
    (or (get-package-name-helper path :lua)
        (get-package-name-helper path :fnl)
        "")))

(fn unload-package []
  (let [package-name (get-package-name)]
    (when (~= package-name "") (tset package.loaded package-name nil))))

{;;
 :get_package_name get-package-name
 :unload_package unload-package}
