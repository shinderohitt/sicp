
;; Exercise 1.17 (fast) multiplication by addition (logarithmic prodecure)
;; Recursive procedure

(define (halve n)
  (/ n 2))
(define (double n)
  (+ n n))

(define (* a b)
  (+ a (mult a b)))

(define (mult a b)
  (if (= b 1)
      0
      (+ a
         (if (even? b)
               (mult (double a) (halve b))
               (mult a (- b 1))))))

(* 10 100) ;; prints 1000
