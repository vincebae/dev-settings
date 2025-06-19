;; Basic function on numbers

(fn zero? [n] (= n 0))

(fn pos? [n] (> n 0))

(fn neg? [n] (< n 0))

(fn even? [n] (= (% n 2) 0))

(fn odd? [n] (= (% n 2) 1))

(fn inc [n] (+ n 1))

(fn dec [n] (- n 1))

;; Utility functions on collections

(fn empty? [coll] (zero? (length coll)))

(fn first [coll] (. coll 1))

(fn last [coll] (. coll (length coll)))

(fn has-value? [coll target]
  (accumulate [found? false _ value (pairs coll) &until found?]
    (= value target)))

(fn partition [n coll]
  (assert (pos? n) "n must be positive")
  (let [result []]
    (var curr [])
    (each [_ x (pairs coll)]
      (table.insert curr x)
      (when (= n (length curr))
        (table.insert result curr)
        (set curr [])))
    result))

;; Utility functions on strings

(fn starts-with [str prefix]
  (let [str-len (length str)
        prefix-len (length prefix)]
    (and (>= str-len prefix-len) (= (string.sub str 1 prefix-len) prefix))))

(fn ends-with [str suffix]
  (let [str-len (length str)
        suffix-len (length suffix)]
    (and (>= str-len suffix-len) (= (string.sub str (- suffix-len)) suffix))))

(local str-need-escape ["\\" "\""])

(fn make-literal [str]
  (let [escaped (accumulate [result "" c (string.gmatch str ".")]
                  (if (has-value? str-need-escape c) (.. result "\\" c)
                      (= c "\n") (.. result "\\n")
                      (.. result c)))]
    (.. "\"" escaped "\"")))

{;;
 : zero?
 :is_zero zero?
 : pos?
 :is_pos pos?
 : neg?
 :is_neg neg?
 : even?
 :is_even even?
 : odd?
 :is_odd odd?
 : inc
 : dec
 : empty?
 :is_empty empty?
 : first
 : last
 : has-value?
 :has_value has-value?
 : partition
 : starts-with
 :starts_with starts-with
 : ends-with
 :ends_with ends-with
 : make-literal
 :make_literal make-literal}
