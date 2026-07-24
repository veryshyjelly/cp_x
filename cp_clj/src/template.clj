(require '[lib.cpio :refer :all])

;; @code begin

(defn solve [n m arr]
  (println (+ n m (reduce + arr))))

(with-tokens [in ()]
  (let [n (read in :int)
        m (read in :int)
        arr (read in [:ints n])]
    (solve n m arr)))

;; @code end
