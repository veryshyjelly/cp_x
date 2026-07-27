;; Created by Ayush Biswas at 2026/07/25 10:39
;; https://atcoder.jp/contests/adt_easy_20260618_1/tasks/abc426_b
;; D - The Odd One Out
;;
;; @head begin
(ns bin.ac-abc426-b)
;; @head end

(require '[lib.cpio :refer [with-tokens]])

;; @code begin

(defn solve [s]
  (->> s
       frequencies
       (some (fn [[k v]] (when (= v 1) k)))))

(with-tokens [_s :str]
  solve)

;; @code end
