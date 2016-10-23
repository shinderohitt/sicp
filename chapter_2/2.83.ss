;; Exercise 2.83.  Suppose you are designing a generic arithmetic system
;; for dealing with the tower of types shown in figure 2.25: integer,
;; rational, real, complex. For each type (except complex), design a
;; procedure that raises objects of that type one level in the
;; tower. Show how to install a generic raise operation that will work
;; for each type (except complex).


;; in integer installation package
(put 'raise 'scheme-number
     (lambda (num)
       (make-rational num 1)))

;; in rational number package
(put 'raise 'rational
     (lambda (rational-num)
       (make-real (/ (numer rational-num)
                     (denom rational-num)))))

;; in real number package
(put 'raise 'real
     (lambda (real-num)
       (make-complex-from-real-imag real-num 0)))


(define (raise x)
  (apply-generic 'raise x))
