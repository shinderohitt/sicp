
;; Exercise 1.22

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
  (cond ((= times 0) #t)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else #f)))


(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (cond ((fast-prime? n 100)
         (report-prime (- (runtime) start-time)))
        (else #f)))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time) #t)


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
(three-primes-larger-than 1000000000000000000001 0)
(three-primes-larger-than 10000000000000000000000000000000000000000001 0)



;; Output for the above (irrelevant lines removed)

;; 10000000019 *** .03000000000000025

;; 10000000033 *** .03000000000000025

;; 10000000061 *** 1.9999999999999574e-2
;; done
;; ;Unspecified return value


;; 1000000000000000000117 *** .03000000000000025

;; 1000000000000000000193 *** 1.9999999999999574e-2

;; 1000000000000000000213 *** 2.0000000000000462e-2
;; done
;; ;Unspecified return value



;; 10000000000000000000000000000000000000000057 *** .04999999999999982

;; 10000000000000000000000000000000000000000079 *** 4.0000000000000036e-2

;; 10000000000000000000000000000000000000000087 *** 4.0000000000000036e-2
;; done
;; ;Unspecified return value



;; We are actually asked to time the primes which we found in
;; the previous Exercise, but they are too small to get any useful
;; outputs (OR fast-prime? is fast - which it is.)
;; So we are using the same old method, finding three smallest primes
;; greater than some number. In this case, we increase the number of digits
;; in input by a factor of 2 for every case. The program also takes (roughly)
;; twice the amount of time when the digits are doubled. Which supports our
;; claim of algorithm being logarithmic.
