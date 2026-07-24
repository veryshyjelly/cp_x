(require '[lib.cpio :refer [with-tokens]])

;; @code begin

(defn solve [n m arr]
  (+ n m (reduce + arr)))

(with-tokens [n :int
              _m :int
              _arr [:ints n]]
  solve)

;; @code end
