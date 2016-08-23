;; An alternate procedural representation of pairs
;; from the one given in the book

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(car (cons 10 30)) ;; 10

;; Because .. (substitution model below)
;; (car (cons 10 30))
;; (car (lambda (m) (m 10 30)))
;; (lambda (10 30) 10)
;; 10

;; cdr with the presentation above
(define (cdr z)
  (z (lambda (p q) q)))

(cdr (cons 10 30)) ;; 30
