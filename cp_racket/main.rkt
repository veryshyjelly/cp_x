#lang racket

(define prices (for/vector ([_ 3]) (read)))

(displayln prices)