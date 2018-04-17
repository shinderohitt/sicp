
;; integers package
(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag 'scheme-number x))

  ;; other definitions

  (put '=zero? '(scheme-number)
       (lambda (x) (= x 0)))
  'done)


;; rational numbers package
(define (install-rational-package)
  ;; internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  ;; others
  (define (=zero? x)
     (= (numer x) 0))
  ;; interface to rest of the system
  (define (tag x) (attach-tag 'rational x))
  ;; others
  (put '=zero? '(rational) =zero?)
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
  (define (=zero? z1)
     (= (real z1) 0))
  ;; interface to rest of the system
  (define (tag z) (attach-tag 'complex z))
  ;; others
  (put '=zero? '(complex) =zero?)
  'done)

(define (=zero? x) (apply-generic '=zero? x))
