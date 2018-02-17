;; Exercise 2.18.  Define a procedure reverse that takes a list as
;; argument and returns a list of the same elements in reverse order:

;; (reverse (list 1 4 9 16 25))
;; (25 16 9 4 1)

(define (reverse l)
  (define (iter oldl newl)
    (if (null? oldl)
        newl
        (iter (cdr oldl) (cons (car oldl) newl))))
  (iter l '()))

(reverse (list 1 2 3 4))
