;; 1.43
(define (repeated f n)
  (lambda (x)
    (if (< n 1)
        (f x)
        ((repeated (compose f f) (- n 2)) x))))
((repeated square 2) 5) ;; 625
