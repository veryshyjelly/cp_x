;; Created by Ayush Biswas at 2026/07/25 12:21
;; https://atcoder.jp/contests/adt_easy_20260107_3/tasks/abc432_a
;; A - Permute to Maximize
;;
;; @head begin
(ns bin.ac-abc432-a
  (:require
   [clojure.string :as str]))
;; @head end

(require '[lib.cpio :refer [with-tokens]])

;; @code begin

(defn solve [digs]
  (->> digs
       sort
       reverse
       str/join))

(with-tokens [_digs [:ints 3]]
  solve)

;; @code end
