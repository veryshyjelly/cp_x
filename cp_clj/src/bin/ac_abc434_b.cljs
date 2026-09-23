;; Created by Ayush Biswas at 2026/07/25 10:54
;; https://atcoder.jp/contests/adt_easy_20260617_1/tasks/abc434_b
;; D - Bird Watching
;;
(ns bin.ac-abc434-b
  (:require [lib.cpio :refer [with-tokens lines]]))

;; @code begin

(defn solve [_n m birds]
  (let [total-weights (->> birds
                           (map #(apply hash-map %))
                           (apply merge-with +))
        counts (->> birds
                    (map first)
                    frequencies)]
    (lines (for [mi (range 1 (inc m))]
             (double (/ (total-weights mi) (counts mi)))))))

(with-tokens '[n :int
              _m :int
              _birds [:grid-ints n 2]]
  solve)

;; @code end
