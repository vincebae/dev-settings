(fn make-literal [str]
  "Update the input string to be suitable to be embedded in vim command,
  by escaping back-slash, double quote and newline characters,
  and surround the whole string with escaped double quotes"
  (let [escaped (accumulate [result "" c (string.gmatch str ".")]
                 (if (or (= c "\\") (= c "\"")) (.. result "\\" c)
                     (= c "\n") (.. result "\\n")
                     (.. result c)))]
    (.. "\"" escaped "\"")))

{;;
 : make-literal
 :make_literal make-literal}
