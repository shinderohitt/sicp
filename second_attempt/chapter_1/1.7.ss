#lang racket

(define (square x) (* x x))

(define (sqrt-iter old-guess guess x)
  (if (good-enough? old-guess guess)
      guess
      (sqrt-iter guess (improve guess x)
                 x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? old-guess guess)
  (< (abs (- old-guess guess)) (* guess 0.0001)))

(define (sqrt x)
  (sqrt-iter 0 1.0 x))

(sqrt 1000000000000)
(sqrt 0.000001)
;; 1000000.0000000054
;; 0.0010000000000000117


