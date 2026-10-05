;; Created by Ayush Biswas at 2026/09/28 15:36
;; https://atcoder.jp/contests/abc337/tasks/abc337_b
;; B - Extended ABC
;;
(ns bin.ac-abc337-b
  (:require [lib.cpio :refer [with-tokens yes-no]]))

;; @code begin

(defn solve [s]
  (->> s 
       (partition-by identity)
       (map first)
       (apply str)
       ((juxt sort seq))
       (apply =)))

(with-tokens '[s :str]
  (comp yes-no solve))

;; @code end

