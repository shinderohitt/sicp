#lang sicp

(define (square x) (* x x))
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

;; 1009 *** 3
;; 1013 *** 4
;; 1019 *** 3
;; ---
;; 10007 *** 8
;; 10009 *** 9
;; 10037 *** 8
;; ---
;; 100003 *** 26
;; 100019 *** 27
;; 100043 *** 26
;; ---
;; 1000003 *** 83
;; 1000033 *** 84
;; 1000037 *** 84

;; Values seem to go up roughly by a factor of 3
;; which is close to root of 10.

;; Note: This was run on Dr.Racket, MIT-SCHEME fails
