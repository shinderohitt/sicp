;; Recursive version
(define (cont-frac n d k)
  (define (cont-frac-iter res xk)
    (if (< xk 1)
        res
        (cont-frac-iter
         (/ (n xk) (+ res (d xk)))
         (- xk 1))))
  (cont-frac-iter (/ (n k) (d k)) (- k 1)))

(define (euler-d x)
  (let* ((xplus1 (+ x 1))
        (xplus1div (/ xplus1 3)))
    (if (= (modulo xplus1 3) 0)
        (- xplus1 xplus1div)
        1)))

(cont-frac (lambda (i) 1.0)
           euler-d
           8)

;Value: .7182795698924731
