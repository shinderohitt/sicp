#lang sicp

(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (fast-prime? n)
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
(search-for-primes 1000000 1000038)

;; 1009 *** 16
;; 1013 *** 16
;; 1019 *** 16
;; ---
;; 1000003 *** 27
;; 1000033 *** 26
;; 1000037 *** 28

;; 1,000,000 seem to take close to twice the amount of time
;; to 1,000 but not quite x2.


(search-for-primes 10000 10038)
(display "\n---")
(search-for-primes 100000000 100000100)

;; 10007 *** 20
;; 10009 *** 22
;; 10037 *** 20
;; ---
;; 100000007 *** 41
;; 100000037 *** 37
;; 100000039 *** 50
;; 100000049 *** 40
;; 100000073 *** 39
;; 100000081 *** 40

;; For larger number it clearly seems to take x2 the time.
