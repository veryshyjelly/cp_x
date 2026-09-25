;; Created by Ayush Biswas at 2026/09/24 18:44
;; https://atcoder.jp/contests/abc394/tasks/abc394_b
;; B - cat
;;
(ns bin.ac-abc394-b
  (:require [lib.cpio :refer [with-tokens]]
            [clojure.string :as str]))

;; @code begin

(defn solve [_n arr]
  (str/join (sort-by count arr)))

(with-tokens '[n :int
               arr [:strs n]]
  solve)

;; @code end

