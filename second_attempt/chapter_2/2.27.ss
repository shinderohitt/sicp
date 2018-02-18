(define (deep-reverse l)
  (define (iter oldl newl)
    (cond ((null? oldl) newl)
          ((pair? (car oldl))
           (iter (cdr oldl) (cons (deep-reverse (car oldl)) newl)))
          (else (iter (cdr oldl) (cons (car oldl) newl)))))
  (iter l '()))

(deep-reverse '((1 2) (3 4))) ;;((4 3) (2 1))
