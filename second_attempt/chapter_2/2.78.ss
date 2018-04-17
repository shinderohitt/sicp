;; modified attach-tag, type-tag, and contents to avoid
;; tag on scheme-numbers
(define (attach-tag type-tag contents)
  (if (number? contents)
      contents
      (cons type-tag contents)))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (if (number? datum)
          datum
          (error "Bad tagged datum -- TYPE-TAG" datum))))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (if (numer? datum)
          datum
          (error "Bad tagged datum -- CONTENTS" datum))))

;; modified package to avoid tags on numbers
(define (install-scheme-number-package)
  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (+ x y)))
  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (- x y)))
  (put 'mul '(scheme-number scheme-number)
       (lambda (x y) (* x y)))
  (put 'div '(scheme-number scheme-number)
       (lambda (x y) (/ x y)))
  (put 'make 'scheme-number
       (lambda (x) x))
  'done)
