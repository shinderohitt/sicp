;; Exercise 1.35
;; Find the Fixed point of golden ratio using fixed-point procedure

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try-guess guess)
    (let ((next (f guess)))
      (if (close-enough guess next)
          next
          (try-guess next))))
  (try-guess first-guess))


;; Golden ratio formula is given
;; x -> 1 + 1/x

(fixed-point (lambda (x) (+ 1 (/ 1 x)))
             1.0)

;; prints 1.6180327868852458
