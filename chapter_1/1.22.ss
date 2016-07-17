
;; Exercise 1.22

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

(three-primes-larger-than 1001 0)
(three-primes-larger-than 100001 0)
(three-primes-larger-than 1000001 0)



;; Below is the output after running code from this buffer
;; on my computer which runs on an core i5 (2450M)

;; 1001
;; 1003
;; 1005
;; 1007
;; 1009 *** 0.
;; 1011
;; 1013 *** 0.
;; 1015
;; 1017
;; 1019 *** 0.
;; done
;; Unspecified return value


;; 100001
;; 100003 *** 0.
;; 100005
;; 100007
;; 100009
;; 100011
;; 100013
;; 100015
;; 100017
;; 100019 *** 0.
;; 100021
;; 100023
;; 100025
;; 100027
;; 100029
;; 100031
;; 100033
;; 100035
;; 100037
;; 100039
;; 100041
;; 100043 *** 0.
;; done
;; Unspecified return value


;; 1000001
;; 1000003 *** .02
;; 1000005
;; 1000007
;; 1000009
;; 1000011
;; 1000013
;; 1000015
;; 1000017
;; 1000019
;; 1000021
;; 1000023
;; 1000025
;; 1000027
;; 1000029
;; 1000031
;; 1000033 *** 0.
;; 1000035
;; 1000037 *** 0.
;; done
;; Unspecified return value


;; The (runtime) procedure doesn't seem to be precise
;; enough to give us the timing data (AND)
;; computers today are way lot faster than they were when
;; this Exercise was written :)
;; Let's try bigger numbers


(three-primes-larger-than 10000000001 0)
;; average time taken : 0.135

(three-primes-larger-than 100000000001 0)
;; average time taken : 0.42

(three-primes-larger-than 1000000000001 0)
;; average time taken : 1.30

;; Outputs given below

;; 10000000001
;; 10000000003
;; 10000000005
;; 10000000007
;; 10000000009
;; 10000000011
;; 10000000013
;; 10000000015
;; 10000000017
;; 10000000019 *** .14000000000000057
;; 10000000021
;; 10000000023
;; 10000000025
;; 10000000027
;; 10000000029
;; 10000000031
;; 10000000033 *** .1399999999999988
;; 10000000035
;; 10000000037
;; 10000000039
;; 10000000041
;; 10000000043
;; 10000000045
;; 10000000047
;; 10000000049
;; 10000000051
;; 10000000053
;; 10000000055
;; 10000000057
;; 10000000059
;; 10000000061 *** .13000000000000078
;; done
;; ;Unspecified return value


;; 100000000001
;; 100000000003 *** .41000000000000014
;; 100000000005
;; 100000000007
;; 100000000009
;; 100000000011
;; 100000000013
;; 100000000015
;; 100000000017
;; 100000000019 *** .4299999999999997
;; 100000000021
;; 100000000023
;; 100000000025
;; 100000000027
;; 100000000029
;; 100000000031
;; 100000000033
;; 100000000035
;; 100000000037
;; 100000000039
;; 100000000041
;; 100000000043
;; 100000000045
;; 100000000047
;; 100000000049
;; 100000000051
;; 100000000053
;; 100000000055
;; 100000000057 *** .4399999999999995
;; done
;; ;Unspecified return value


;; 1000000000001
;; 1000000000003
;; 1000000000005
;; 1000000000007
;; 1000000000009
;; 1000000000011
;; 1000000000013
;; 1000000000015
;; 1000000000017
;; 1000000000019
;; 1000000000021
;; 1000000000023
;; 1000000000025
;; 1000000000027
;; 1000000000029
;; 1000000000031
;; 1000000000033
;; 1000000000035
;; 1000000000037
;; 1000000000039 *** 1.2899999999999991
;; 1000000000041
;; 1000000000043
;; 1000000000045
;; 1000000000047
;; 1000000000049
;; 1000000000051
;; 1000000000053
;; 1000000000055
;; 1000000000057
;; 1000000000059
;; 1000000000061 *** 1.3099999999999987
;; 1000000000063 *** 1.3200000000000003
;; done
;; ;Unspecified return value



;; So the time taken by increasing input by a factor
;; of 10 takes more time by a factor of 3 (roughly)
;; which is (3) rouchly equal to √10
