#lang racket

(define (partial-sums s)
  (let* ((first (stream-first s))
         (rest (stream-rest s))
         (second (stream-first rest)))
    (stream-cons first
                 (partial-sums
                  (stream-cons (+ first second) (stream-rest rest))))))

(stream-ref (partial-sums integers) 4) ;; 15
