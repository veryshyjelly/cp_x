;; Created by Ayush Biswas at 2026/07/25 11:24
;; https://atcoder.jp/contests/adt_easy_20260407_2/tasks/abc448_b
;; C - Pepper Addiction
;;
;; @head begin
(ns bin.ac-abc448-b)
;; @head end

(require '[lib.cpio :refer [with-tokens]])

;; @code begin

(defn solve [_n m stocks wants]
  (let [wants (->> wants
                   (map #(apply hash-map %))
                   (apply merge-with +))]
    (apply +
           (for [mi (range m)]
             (min (stocks mi) (get wants (inc mi) 0))))))

(with-tokens [n :int m :int
              _stocks [:ints m]
              _wants [:grid-ints n 2]]
  solve)

;; @code end
