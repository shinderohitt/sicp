
;; Implement "raise" for each package

;; scheme-number package
(put 'raise 'integer
     (lambda (x) (make-rational x 1)))
;; Rational package
(put 'raise 'rational
     (lambda (x) (make-real (/ (numer x) (denom x)))))
;; Real package
(put 'raise 'real
     (lambda (x) (make-from-real-imag x 0)))

;; add generic
(define (raise x) (apply-generic 'raise x))
