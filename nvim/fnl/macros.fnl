(macro cond-> [val ...]
  (let [my (require :utils.my_utils)]
    (assert (my.even? (length [...])))
    (let [partitioned (my.partition 2 [...])]
      (var x val)
      (each [_ elem (ipairs partitioned)]
        (case elem
          [test expr] (set x `(if ,test (-> ,x ,expr) ,x))))
      x)))
