;; Created by Ayush Biswas at 2026/09/24 17:48
;; https://atcoder.jp/contests/abc380/tasks/abc380_a
;; A - 123233
;;
(ns bin.ac-abc380-a
  (:require [lib.cpio :refer [with-tokens yes-no]]
            [clojure.string :as str]))

;; @code begin

(defn solve [s]
  (= (str/join (sort s)) "122333"))

(with-tokens '[s :str]
  (comp yes-no solve))

;; @code end

