(define (my-equal? l1 l2)
  (let* ((both-lists? (and (list? l1) (list? l2)))
         (both-symbols? (and (symbol? l1) (symbol? l2))))
    (cond ((and both-lists?
                (null? l1)
                (null? l2)) #t)
          (both-symbols? (eq? l1 l2))
          ((or (null? l1) (null? l2)) #f)
          (else (and (eq? (car l1) (car l2))
                     (my-equal? (cdr l1) (cdr l2)))))))

(my-equal? 'blah 'blah) ;; #t
(my-equal? '(rohi ta) '(rohi ta)) ;; #t

(my-equal? 'blah 'bla) ;; #f
(my-equal? '() '(foo)) ;; #f
