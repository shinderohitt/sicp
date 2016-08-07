;; Exercies 1.33) a variation of 1.32 accumulator procedure
;; should take one more parameter (predicate) and consider
;; only elements from the range which match that predicate

;; accumulate

(define (accumulate combiner
                    null-value
                    predicate
                    term a next b)
  (cond ((> a b) null-value)
        ((predicate a) (combiner (term a)
                                 (accumulate combiner
                                             null-value
                                             predicate
                                             term (next a)
                                             next b)))
        (else (accumulate combiner
                          null-value
                          predicate
                          term (next a)
                          next b))))


(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (inc a)
  (+ a 1))
(define (identity a) a)

(define (prime-sums-within a b)
  (accumulate + 0 prime? identity a inc b))

(define (sum-of-rel-primes-n n)
  (define (relative-prime x)
    (if (= 1 (gcd x n))
        #t
        #f))
  (accumulate + 0 relative-prime identity 1 inc n))


;; a. Sum of all primes within a given range
(prime-sums-within 1 10) ;; 18

;; b. Sum of all integers less than n,
;; that are relative prime to n
(sum-of-rel-primes-n 10)
