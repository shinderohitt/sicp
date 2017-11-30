#lang racket

(define (square x) (* x x))

(define (cbrt-iter old-guess guess x)
  (if (good-enough? old-guess guess)
      guess
      (cbrt-iter guess (improve guess x)
                 x)))

(define (improve guess x)
  (/ (+ (/ x (square guess))
        (* 2 guess))
     3))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? old-guess guess)
  (< (abs (- old-guess guess)) (* guess 0.0001)))

(define (cbrt x)
  (cbrt-iter 0 1.0 x))

(cbrt 27)
;; 3.0000000000000977
