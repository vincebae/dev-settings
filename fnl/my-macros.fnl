(fn zero? [n]
  `(= ,n 0))

(fn pos? [n]
  `(> ,n 0))

(fn neg? [n]
  `(< ,n 0))

(fn even? [n]
  `(= (% ,n 2) 0))

(fn odd? [n]
  `(= (% ,n 2) 1))

(fn inc [n]
  `(+ ,n 1))

(fn dec [n]
  `(- ,n 1))

(fn nil? [x]
  `(= ,x nil))

(fn empty? [x]
  `(zero? (length ,x)))

{;;
 : zero?
 : pos?
 : neg?
 : even?
 : odd?
 : inc
 : dec
 : nil?
 : empty?}
