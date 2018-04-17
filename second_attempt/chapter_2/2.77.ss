
(put 'real-part '(complex) real-part)
(put 'imag-part '(complex) imag-part)
(put 'magnitude '(complex) magnitude)
(put 'angle '(complex) angle)

;; The code above adds generic complex number selectors
;; to the complex package.

;; So, invoking
;; (magnitude z) on complex package would look up the
;; generic selectors that were defined for real/magnitude packages.

;; Those selectors in turn look up the selectors internal to
;; their respective packages. Here is what the definition looks like

(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))

;; which are calling apply-generic in turn -- which looks up for tag on z
;; so, based on the tag, it calls appropriate selector. For instance,

;; if the given z was represented by using real-imag numbers,
;; for (apply-generic 'real-part z) apply-generic does a
;; (get 'real-part '(real))
;; which gets the right procedure to apply to get the real part of z.


;; With the (complex) package in front of (polar) and (real) packages,
;; we would dispatch twice for (magnitude z).
