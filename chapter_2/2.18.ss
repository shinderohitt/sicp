;; Define a procedure reverse that takes
;; a list as argument and returns a list of
;; the same elements in reverse order

(define (reverse l)
  (define (do-reverse lat r)
    (if (null? lat)
        r
        (do-reverse (cdr lat) (cons (car lat) r))))
  (do-reverse l '()))

(reverse '(1 2 3))
;; (3 2 1)
