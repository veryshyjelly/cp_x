;; Created by Ayush Biswas at 2026/07/25 13:35
;; https://atcoder.jp/contests/adt_easy_20251023_3/tasks/abc419_b
;; D - Get Min
;;
;; @head begin
(ns bin.ac-abc419-b
  (:require [clojure.data.priority-map :refer [priority-map]]))
;; @head end

(require '[lib.cpio :refer [with-tokens lines]])

;; @code begin

(defn solve [_q queries]
  (->> (reduce (fn [[res queue] query]
                 (case (first query)
                   :push [res (assoc queue (rand) (second query))]
                   :pop
                   [(->> queue peek second (conj res))
                    (pop queue)]))
               [[] (priority-map)]
               queries)
       first
       lines))

(with-tokens [q :int
              _queries [:queries q {1 [:push :int]
                                    2 [:pop]}]]
  solve)

;; @code end
