
;; integers package
(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag 'scheme-number x))

  ;; other definitions

  (put 'equ? '(scheme-number scheme-number)
       (lambda (x y) (= x y)))
  'done)


;; rational numbers package
(define (install-rational-package)
  ;; internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  ;; others
  (define (eq? x y)
    (and (= (numer x) (numer y))
         (= (denom x) (denom y))))
  ;; interface to rest of the system
  (define (tag x) (attach-tag 'rational x))
  ;; others
  (put 'equ? '(rational rational) equ?)
  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))
  'done)

;; complex number package
(define (install-complex-package)
  ;; imported procedures from rectangular and polar packages
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))
  ;; internal procedures
  ;; others
  (define (equ? z1 z2)
    (and (= (real z1) (real z2)
            (angle z1) (angle z2))))
  ;; interface to rest of the system
  (define (tag z) (attach-tag 'complex z))
  ;; others
  (put 'eq? '(complex complex) equ?)
  'done)

(define (equ? x y) (apply-generic 'equ? x y))
