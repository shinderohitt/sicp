#lang sicp
(#%require sicp-pict)

;; Wrote this in DrRacket v6.6

(define (split pos1 pos2)
  (define (inner painter n)
    (if (= n 0)
        painter
        (let ((smaller (inner painter (- n 1))) )
          (pos2 painter (pos1 smaller smaller)))))
  inner)
     

(define up-split (split beside below))
(define right-split (split below beside))

(paint (up-split einstein 1))
(paint (right-split einstein 1))