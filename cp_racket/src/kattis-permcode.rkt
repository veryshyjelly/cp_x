; Created by Ayush Biswas at 2025/10/16 12:48
; https://open.kattis.com/problems/permcode
#lang racket

(define prices (for/vector ([_ 3]) (read)))

(displayln prices)