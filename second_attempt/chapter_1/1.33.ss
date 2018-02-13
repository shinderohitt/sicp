(define (filtered-accumulate combiner predicate null-value term a next b)
  (define (add-if-true x acc)
    (if (predicate x)
        (combiner acc (term x))
        acc))
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (add-if-true a result))))
  (iter a null-value))

(define (identity x) x)
(define (inc x) (+ x 1))
;; sum of even numbers between 1-5
(filtered-accumulate + even? 0 identity 1 inc 5) ;; 6

;; sum of odd numbers between 1-5
(filtered-accumulate + odd? 0 identity 1 inc 5) ;; 9

;; sum of squares of all primes between given range
(define (sum-of-squares-in a b)
  (filtered-accumulate + prime? 0 square a inc b))

;; sum of all positives less than n that are relative prime to n
(define (sum-of-positives-relative-prime n)
  (define (relative-prime? x) (= (gcd x n) 1))
  (filtered-accumulate + relative-prime? 0 identity a inc b))
