;; Created by Ayush Biswas at 2026/07/25 12:21
;; https://atcoder.jp/contests/adt_easy_20260107_3/tasks/abc432_a
;; A - Permute to Maximize
;;
(ns bin.ac-abc432-a
  (:require [lib.cpio :refer [with-tokens]]
            [clojure.string :as str]))

;; @code begin

(defn solve [digs]
  (->> digs
       sort
       reverse
       str/join))

(with-tokens '[digs [:ints 3]]
  solve)

;; @code end
