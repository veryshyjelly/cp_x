(ns template 
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [n xs]
  (+ n (reduce + xs)))

(with-tokens '[n :int
               xs [:ints n]]
  solve)

;; @code end
