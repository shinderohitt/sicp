
;; Write a procedure same-parity that takes one or more integers
;; and returns a list of all the arguments that have the same even-odd parity
;; as the first argument. For example,


(define (same-parity first . others)

  (define (with-same-parity fits? lat)
    (cond ((null? lat) lat)
          ((fits? (car lat))
           (cons (car lat) (with-same-parity fits? (cdr lat))))
          (else
           (with-same-parity fits? (cdr lat)))))

  (if (even? first)
      (with-same-parity even? (cons first others))
      (with-same-parity odd? (cons first others))))


(same-parity 1 2 3 4 5 6 7)
;; (1 3 5 7)
