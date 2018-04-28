;; keep pointers of seen cars,
;; and check if one of cdr's points
;; to it. if it does, then there is a loop.
(define pairs-table (make-strong-eq-hash-table 10))
(define (has-loop? x)
  (cond ((null? x) #f)
        ((not (pair? x)) #f)
        ((hash-table/get pairs-table (cdr x) #f) #t)
        (else
         (begin (hash-table/put! pairs-table x #t)
                (has-loop? (cdr x))))))

(define z (list 1 2))
(set-cdr! (cdr z) z)

(has-loop? '(1 2 3)) ;; #f
(has-loop? z)        ;; #t
