#lang racket

(define (partial-sums s)
  (let* ((first (stream-first s))
         (rest (stream-rest s))
         (second (stream-first rest)))
    (stream-cons first
                 (partial-sums
                  (stream-cons (+ first second) (stream-rest rest))))))

(define (natlog-summands n)
  (stream-cons
   (/ 1.0 n)
   (stream-map - (natlog-summands (+ n 2)))))

(define natlog-stream
  (partial-sums (natlog-summands 1))

(display-stream natlog-stream)
