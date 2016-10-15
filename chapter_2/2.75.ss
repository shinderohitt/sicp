;; Exercise 2.75.  Implement the constructor make-from-mag-ang in message-passing
;; style. This procedure should be analogous to the make-from-real-imag procedure
;; given above.

(define (make-from-mag-ang x y)
  (define (dispatch op)
    (cond ((eq? op 'real-part) (* r (cos a)))
          ((eq? op 'imag-part) (* r (sin a)))
          ((eq? op 'magnitude) x)
          ((eq? op 'angle) y)
          (else
           (error "Unknown op -- MAKE-FROM-REAL-IMAG" op))))
  dispatch)
