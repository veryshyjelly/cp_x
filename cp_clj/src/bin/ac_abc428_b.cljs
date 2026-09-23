;; Created by Ayush Biswas at 2026/07/24 23:10
;; https://atcoder.jp/contests/adt_all_20260623_2/tasks/abc428_b
;; D - Most Frequent Substrings
;;
(ns bin.ac-abc428-b
  (:require [lib.cpio :refer [with-tokens lines words]]
            [clojure.string :as str]))

;; @code begin

(defn solve [_n k s]
  (let [freqs (->> s
                   (partition k 1)
                   (map str/join)
                   frequencies)
        max-freq (apply max (vals freqs))
        most-freqs (keep (fn [[k v]]
                           (when (= v max-freq) k)) freqs)]
    (lines (list max-freq
                 (words (sort most-freqs))))))

(with-tokens '[_n :int _k :int
              _s :str]
  solve)

;; @code end
