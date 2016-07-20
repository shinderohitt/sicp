
(define (fast-expt b n)
  (cond ((= n 1) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (expmod2 base exp m)
  (remainder (fast-expt base exp) m))


(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))


(expmod 2 3 4)
(expmod 3 7 4)
(expmod 10 3 2)

(expmod2 2 3 4)
(expmod2 3 7 4)
(expmod2 10 3 2)

