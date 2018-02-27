;; Give a (n) implementation of union-set for sets represented as ordered
;; lists.

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else
         (let ((x1 (car set1))
               (x2 (car set2))
               (set1tail (cdr set1))
               (set2tail (cdr set2)))
           (cond ((= x1 x2)
                  (cons x1 (union-set set1tail set2tail)))
                 ((< x1 x2)
                  (cons x1 (union-set set1tail set2)))
                 (else
                  (cons x2 (union-set set1 set2tail))))))))
