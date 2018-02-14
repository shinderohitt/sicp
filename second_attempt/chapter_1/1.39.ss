;; Recursive version
(define (cont-frac n d k)
  (define (cont-frac-iter res xk)
    (if (< xk 1)
        res
        (cont-frac-iter
         (/ (n xk) (+ res (d xk)))
         (- xk 1))))
  (cont-frac-iter (/ (n k) (d k)) (- k 1)))


(define (tan-cf x k)
  (cont-frac (lambda (i)
               (exact->inexact (if (= i 1) x (- (square x)))))
             (lambda (i) (+ i (- i 1)))
             k))
(tan-cf 5 11)

;Value: -3.380526061034825
