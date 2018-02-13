;; recursive version
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

;; iterative
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter (term a) 0))

(sum (lambda (x) x) 1 (lambda (x) (+ x 1)) 10)
;; 55
