
;; Exercise 1.8
;; This is just a slight change (in procedure `improve`)
;; from the last exercise
(define (cube x)
  (* x x x))
(define (good-enough? guess x)
  (< (abs (- (cube guess) x)) 0.0000001))
(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (/ (+ (/ x (square guess))
        (* 2 guess))
     3))
(define (cbrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (cbrt-iter (improve guess x)
                 x)))
(define (cbrt x)
  (cbrt-iter 1.0 x))

(cbrt 100)
