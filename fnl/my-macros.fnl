;; [nfnl-macro]

;; Basic utility functions
(fn nil? [x]
  `(= ,x nil))

;; Utility functions on numbers
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

;; Utility functions on collections
(fn empty? [x]
  `(let [x# ,x]
     (or (= x# nil) (= (length x#) 0))))

(fn not-empty? [x]
  `(let [x# ,x]
     (and x# (> (length x#) 0))))

(fn first [coll]
  `(. ,coll 1))
(fn second [coll]
  `(. ,coll 2))
(fn third [coll]
  `(. ,coll 3))
(fn fourth [coll]
  `(. ,coll 4))
(fn fifth [coll]
  `(. ,coll 5))
(fn sixth [coll]
  `(. ,coll 6))
(fn seventh [coll]
  `(. ,coll 7))
(fn eighth [coll]
  `(. ,coll 8))
(fn nineth [coll]
  `(. ,coll 9))
(fn tenth [coll]
  `(. ,coll 10))

(fn last [coll]
  `(let [len# (length ,coll)]
     (. ,coll len#)))

(fn has-value? [coll target]
  `(accumulate [found?# false _# value# (pairs ,coll) &until found?#]
     (= value# ,target)))

(fn map [f coll]
  `(icollect [_# v# (ipairs ,coll)] (,f v#)))

(fn filter [pred coll]
  `(icollect [_# v# (ipairs ,coll)]
     (when (,pred v#) v#)))

(fn reduce [f acc coll]
  `(accumulate [result# ,acc _# value# (ipairs ,coll)]
     (,f result# value#)))

(fn keys [table]
  `(icollect [k# _# (pairs ,table)] k#))

(fn vals [table]
  `(icollect [_# v# (pairs ,table)] v#))

;; Utility functions on strings

(fn blank? [str]
  `(let [s# ,str]
     (or (= s# nil) (= s# ""))))

(fn not-blank? [str]
  `(let [s# ,str]
     (and s# (~= s# ""))))

(fn starts-with? [str prefix]
  `(let [p# ,prefix]
    (= (string.sub ,str 1 (length p#)) p#)))

(fn ends-with? [str suffix]
  `(let [s# ,suffix]
    (= (string.sub ,str (- (length s#))) s#)))

;; Internal function for other macros below
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

(fn cond-> [val ...]
  (assert (= (% (length [...]) 2) 0))
  (let [partitioned (partition 2 [...])]
    (var x val)
    (each [_ elem (ipairs partitioned)]
      (case elem
        [test expr]
        (set x `(let [x# ,x] (if ,test (-> x# ,expr) x#)))))
    x))

(fn cond->> [val ...]
  (assert (= (% (length [...]) 2) 0))
  (let [partitioned (partition 2 [...])]
    (var x val)
    (each [_ elem (ipairs partitioned)]
      (case elem
        [test expr]
        (set x `(let [x# ,x] (if ,test (->> x# ,expr) x#)))))
    x))

{;;
 : nil?
 : zero?
 : pos?
 : neg?
 : even?
 : odd?
 : inc
 : dec
 : empty?
 : not-empty?
 : first
 : second
 : third
 : fourth
 : fifth
 : sixth
 : seventh
 : eighth
 : nineth
 : tenth
 : last
 : has-value?
 : map
 : filter
 : reduce
 : keys
 : vals
 : blank?
 : not-blank?
 : starts-with?
 : ends-with?
 : cond->
 : cond->>}
