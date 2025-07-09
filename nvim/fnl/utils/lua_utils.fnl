(local pu (require :utils.path_utils))

(fn get-package-name []
 (fn helper [path file-type]
   (let [file-pattern (case file-type
                        :lua ".*/lua/(.*).lua$"
                        :fnl ".*/fnl/(.*).fnl$")
         extracted (string.match path file-pattern)]
     (when extracted (string.gsub extracted "/" "."))))

 (let [path (pu.get-buffer-path)]
   (or (helper path :lua)
       (helper path :fnl)
       "")))

(fn unload-package []
  (let [package-name (get-package-name)]
    (when (~= package-name "") (tset package.loaded package-name nil))))

{;;
 :get_package_name get-package-name
 :unload_package unload-package}
