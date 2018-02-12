#lang sicp

(define (square x) (* x x))
(define (next x)
  (if (= x 2) 3 (+ x 2)))
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime n (- (runtime) start-time))))
(define (report-prime n elapsed-time)
  (display "\n")
  (display n)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes start end)
  (define (odd-start)
    (if (even? start) (+ start 1) start))
  (define (searcher startn endn)
    (if (< startn endn) (timed-prime-test startn))
    (if (< startn endn) (search-for-primes (+ startn 2) endn)))
  (searcher (odd-start) end))

(search-for-primes 1000 1020)
(display "\n---")
(search-for-primes 10000 10039)
(display "\n---")
(search-for-primes 100000 100044)
(display "\n---")
(search-for-primes 1000000 1000038)

#lang sicp

(define (square x) (* x x))
(define (next x)
  (if (= x 2) 3 (+ x 2)))
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime n (- (runtime) start-time))))
(define (report-prime n elapsed-time)
  (display "\n")
  (display n)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes start end)
  (define (odd-start)
    (if (even? start) (+ start 1) start))
  (define (searcher startn endn)
    (if (< startn endn) (timed-prime-test startn))
    (if (< startn endn) (search-for-primes (+ startn 2) endn)))
  (searcher (odd-start) end))

(search-for-primes 1000 1020)
(display "\n---")
(search-for-primes 10000 10039)
(display "\n---")
(search-for-primes 100000 100044)
(display "\n---")
(search-for-primes 1000000 1000038)

;; 1009 *** 1
;; 1013 *** 1
;; 1019 *** 2
;; ---
;; 10007 *** 5
;; 10009 *** 5
;; 10037 *** 4
;; ---
;; 100003 *** 15
;; 100019 *** 14
;; 100043 *** 14
;; ---
;; 1000003 *** 44
;; 1000033 *** 44
;; 1000037 *** 44

;; Looks like the imporovement is ~1.9, but not 2.
;; Though we halve the input size, we add an extra
;; if condition
