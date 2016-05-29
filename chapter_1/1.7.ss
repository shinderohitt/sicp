
;; 1.7
;; With very small numbers, our limiting factor is the number 0.001.
;; We are "okay" with approximations that are within that range.
;; Which is why the given solution fails for above.
;; For very large numbers, (I guess) the issue is with the
;; computer's limitation of representing a large floating point number.
;; TODO: Learn the exact reason
(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))
(define (good-enough? prev-guess guess x)
  (< (abs (- prev-guess guess)) 0.00000000000001))
(define (sqrt-iter prev-guess guess x)
  (if (good-enough? prev-guess guess x)
      guess
      (sqrt-iter guess
                 (improve guess x)
                 x)))
(define (sqrt x)
  (sqrt-iter 0.0 1.0 x))
(sqrt 100)

