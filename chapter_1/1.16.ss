
;; Exercise 1.16.
;; Design a procedure that evolves an iterative exponentiation process,
;; that uses successive squaring and uses a logarithmic number of steps



(define (fast-expt2 b n)
  (fast-expt-iter b n 1))
(define (fast-expt-iter b n a)
  (if (= n 1)
      a
      (if (even? n)
          (fast-expt-iter b
                          (/ n 2)
                          (* (square b) a))
          (fast-expt-iter b
                          (- n 1)
                          (* a b)))))
(fast-expt2 12 2)

