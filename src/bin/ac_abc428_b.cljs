;; Created by Ayush Biswas at 2026/07/24 23:10
;; https://atcoder.jp/contests/adt_all_20260623_2/tasks/abc428_b
;; D - Most Frequent Substrings
;;
(ns bin.ac-abc428-b
  (:require [lib.cpio :refer [with-tokens lines-of-words]]
            [clojure.string :as str]))

;; @code begin

(defn solve [_n k s]
  (let [freqs (->> s (partition k 1) (map str/join) frequencies)
        max-freq (apply max (vals freqs))
        most-freqs (for [[k v] freqs
                         :when (= v max-freq)] k)]
    [[max-freq]
     (vec (sort most-freqs))]))

(with-tokens '[n :int k :int
               s :str]
  (comp lines-of-words solve))

;; @code end
