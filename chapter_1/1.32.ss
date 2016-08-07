;; Exercies 1.32) combiner previous two methods to make a
;; more generalized version - accumulate

;; accumulate

;; recursive
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

;; iterative
(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)
              (combiner (term a) result))))
  (iter a null-value))

;; test for integers product
(define (inc a)
  (+ a 1))
(define (identity a) a)
(define (multiply-integers a b)
  (accumulate * 1 identity a inc b))

(multiply-integers 1 10) ;; 3628800


;; test for summing integers
(define (sum-integers a b)
  (accumulate + 0 identity a inc b))

(sum-integers 1 5) ;; 15
