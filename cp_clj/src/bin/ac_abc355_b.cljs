;; Created by Ayush Biswas at 2026/09/28 12:42
;; https://atcoder.jp/contests/abc355/tasks/abc355_b
;; B - Piano 2
;;
(ns bin.ac-abc355-b
  (:require [lib.cpio :refer [with-tokens yes-no]]))

;; @code begin

(defn solve [_ _ a b]
  (let [a (map #(-> [% :a]) a)
        b (map #(-> [% :b]) b)
        c (sort (concat a b))]
    (->>  c
          (map second)
          (partition 2 1)
          (some (partial apply = :a)))))

(with-tokens '[n :int m :int
               a [:ints n]
               b [:ints m]]
  (comp yes-no solve))

;; @code end

