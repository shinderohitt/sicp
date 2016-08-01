
;; write a similar procedure analogous to sum (from 1.30)
;; for product

;; recursive
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

;; (iterative)
(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))
  (iter a 1))

;; test for summing integers
(define (inc a)
  (+ a 1))
(define (identity a) a)
(define (multiply-integers a b)
  (product identity a inc b))

;; (multiply-integers 1 10) ;; 3628800

;; factorial in terms of product
(define (factorial n)
  (multiply-integers 1 n))
;; (factorial 10) ;; 3628800


;; π approximation using Wallis Product
(define (wallis-product n)
  (define (term x)
    (/ (* 4.0 (square x))
      (- (* 4.0 (square x)) 1)))
  (* 2 (product term 1 inc n)))

(wallis-product 10000) ;Value: 3.1415141186819566