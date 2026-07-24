;; Created by Ayush Biswas at 2026/07/24 16:53
;; https://atcoder.jp/contests/adt_all_20260629_2/tasks/abc242_b
;; D - Minimize Ordering
;;
;; @head begin
(ns bin.ac-abc242-b
  (:require
   [clojure.string :as str]))
;; @head end

(require '[lib.cpio :refer :all])

;; @code begin

(defn solve [s]
  (->> s
       sort
       str/join
       println))

(with-tokens [in ()]
  (let [s (read in :str)]
    (solve s)))

;; @code end
