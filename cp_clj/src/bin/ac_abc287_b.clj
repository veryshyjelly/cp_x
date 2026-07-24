;; Created by Ayush Biswas at 2026/07/24 22:28
;; https://atcoder.jp/contests/adt_easy_20260625_1/tasks/abc287_b
;; C - Postal Card
;;
;; @head begin
(ns bin.ac-abc287-b)
;; @head end

(require '[lib.cpio :refer [with-tokens]])

;; @code begin

(defn solve [_ _ s t]
  (let [t (set t)]
    (count (keep #(t (subs % 3)) s))))

(with-tokens [n :int
              m :int
              _s [:strs n]
              _t [:strs m]]
  solve)

;; @code end
