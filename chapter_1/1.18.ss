
;; Exercise 1.18 (fast) multiplication by addition (logarithmic prodecure)
;; Iterative procedure

(define (halve n)
  (/ n 2))
(define (double n)
  (+ n n))

(define (* a b)
  (+ a (mult a b 0)))

(define (mult a b sum)
  (if (= b 1)
      sum
      (if (even? b)
          (mult (double a) (halve b) (+ sum a))
          (mult a (- b 1) (+ sum a)))))

(* 10 100) ;; prints 1000
