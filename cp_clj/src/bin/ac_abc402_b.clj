;; Created by Ayush Biswas at 2026/07/25 16:47
;; https://atcoder.jp/contests/adt_easy_20250903_1/tasks/abc402_b
;; D - Restaurant Queue
;;
;; @head begin
(ns bin.ac-abc402-b)
;; @head end

(require '[lib.cpio :refer [with-tokens lines]])

;; @code begin

(defn solve [_q queries]
  (->> (reduce (fn [[res queue] query]
                 (case (first query)
                   :push [res (conj queue (second query))]
                   :pop [(conj res (peek queue)) (pop queue)]))
               [[] clojure.lang.PersistentQueue/EMPTY]
               queries)
       first
       lines))

(with-tokens [q :int
              _queries [:queries q {1 [:push :int]
                                    2 [:pop]}]]
  solve)

;; @code end
