
;; Exercise 1.22

(define (next n)
  (if (= n 2)
      3
      (+ n 2)))

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
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (cond ((prime? n)
         (report-prime (- (runtime) start-time)))
        (else #f)))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time) #t)



;; Now we are supposed to find smallest three primes
;; greater than
;; 1000, 100000, 1000000 and time them

(define (three-primes-larger-than n total-found)
  (cond ((< total-found 3)
         (cond ((timed-prime-test n)
                (three-primes-larger-than
                 (+ n 2)
                 (+ total-found 1)))
               (else
                (three-primes-larger-than
                 (+ n 2)
                 total-found))))
        (else (newline)
              (display "done"))))




(three-primes-larger-than 10000000001 0)
;; average time taken : 0.135 
;; average time taken : 0.08  (with next)

(three-primes-larger-than 100000000001 0)
;; average time taken : 0.42  
;; average time taken : 0.24  (with next)

(three-primes-larger-than 1000000000001 0)
;; average time taken : 1.30
;; average time taken : 0.75  (with next)


;; So with next we are avoiding half the calculations
;; and the timings seem to show the same thing.
;; But it is not exactly half the size,
;; because of the extra added IF statement
;; in the next function.
