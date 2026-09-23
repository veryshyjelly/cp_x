;; Created by Ayush Biswas at 2026/07/25 12:24
;; https://atcoder.jp/contests/adt_easy_20251224_1/tasks/abc432_b
;; C - Permute to Minimize
;;
(ns bin.ac-abc432-b
  (:require [clojure.string :as str]
            [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn digits [i]
  (if (= (quot i 10) 0) [i]
      (conj (digits (quot i 10)) (rem i 10))))

(defn solve [n]
  (let [digs (sort (digits n))
        [k v]
        (some (fn [[k v]] (when (not= v 0) [k v]))
              (map-indexed vector digs))]
    (-> (apply vector digs)
        (assoc k 0)
        (assoc 0 v)
        str/join)))

(with-tokens '[_n :int]
  solve)

;; @code end
