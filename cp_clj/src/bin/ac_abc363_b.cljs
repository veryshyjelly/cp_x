;; Created by Ayush Biswas at 2026/09/24 18:37
;; https://atcoder.jp/contests/abc363/tasks/abc363_b
;; B - Japanese Cursed Doll
;;
(ns bin.ac-abc363-b
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [_n t p hairs]
  (->> hairs
       sort
       reverse
       (take p)
       last
       (- t)
       (#(if (> % 0) % 0))))

(with-tokens '[n :int t :int p :int
              hairs [:ints n]]
  solve)

;; @code end

