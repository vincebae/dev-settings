(local pu (require :utils.path_utils))

(fn get-package-name []
  (let [path (pu.get_buffer_path)
             extracted (string.match path ".*/lua/(.*).lua$")]
    (if extracted (string.gsub extracted "/" ".") "")))

(fn unload-package []
  (let [package-name (get-package-name)]
    (when (~= package-name "") (tset package.loaded package-name nil))))

{;;
 :get_package_name get-package-name
 :unload_package unload-package}
