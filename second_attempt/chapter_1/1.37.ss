;; Recursive version
(define (cont-frac n d k)
  (define (cont-frac-rec xk)
    (if (< xk 1)
        (/ (n xk) (d xk))
        (+ (d xk) (/ (n xk) (cont-frac-rec (- xk 1))))))
  (/ (n k) (cont-frac-rec (- k 1))))

;; Iterative version
(define (cont-frac n d k)
  (define (cont-frac-iter res xk)
    (if (< xk 1)
        res
        (cont-frac-iter
         (/ (n xk) (+ res (d xk)))
         (- xk 1))))
  (cont-frac-iter (/ (n k) (d k)) (- k 1)))

(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           11)

;; k=11
;Value: .6180555555555556
