
;; Exercise 1.27

;; They ask us to write a procedure that would confirm
;; that Fermat's test would fail on Carmichael numbers
;; ie., the non-prime numbers that fool the Fermat test

(define (expmod base exp m)
  (cond
   ((= exp 0) 1)
   ((even? exp)
    (remainder (square (expmod base (/ exp 2) m))
               m))
   (else
    (remainder (* base (expmod base (- exp 1) m))
               m))))

(define (fermat-test n with)
  (= (expmod with n n) with))

(define (fast-prime? n)
  (define (iter n times)
    (cond ((= times n) #t)
          ((fermat-test n times)
           (iter n (+ times 1)))
          (else #f)))
  (iter n 2))


;; Regular Prime
(fast-prime? 277)   ;; #t
;; A non-prime
(fast-prime? 280)   ;; #f

;; Carmichael Numbers
(fast-prime? 561)   ;; #t
(fast-prime? 1105)  ;; #t
(fast-prime? 1729)  ;; #t
(fast-prime? 2465)  ;; #t
(fast-prime? 2821)  ;; #t
(fast-prime? 6601)  ;; #t


