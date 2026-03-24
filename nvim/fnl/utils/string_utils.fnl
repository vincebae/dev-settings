(fn trim [str]
  "Trim leading and trailing whitespaces from the string"
  (string.gsub str "^%s*(.-)%s*$" "%1"))

(fn make-literal [str]
  "Update the input string to be suitable to be embedded in vim command,
  by escaping back-slash, double quote and newline characters,
  and surround the whole string with escaped double quotes"
  (let [escaped (accumulate [result "" c (string.gmatch str ".")]
                 (if (or (= c "\\") (= c "\"")) (.. result "\\" c)
                     (= c "\n") (.. result "\\n")
                     (.. result c)))]
    (.. "\"" escaped "\"")))

(fn make-literals [str delimiter]
  "Apply make-literal to the individual elements of str,
   by splitting str using the delimiter, applying make-literal to each item,
   and joining them again using delimiter followed by a space"
  (let [items []
        pattern (.. "[^" delimiter "]+")]
    (each [item (string.gmatch str pattern)]
      (table.insert items (make-literal (trim item))))
    (table.concat items (.. delimiter " "))))

{;;
 : make-literal
 :make_literal make-literal
 : make-literals
 :make_literals make-literals
 : trim}
