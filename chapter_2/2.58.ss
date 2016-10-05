
;; The differentiation program with abstract data
;; Exercise 2.57

;; (a)
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))

(define (make-exponent base exponent)
  (cond ((= exponent 0) 1)
        ((= exponent 1) base)
        (else (list '** base exponent))))

(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))
(define (addend s) (car s))
(define (augend s)
  (if (null? (cdddr s))
      (caddr s)
      (cons '+ (cddr s))))

(define (product? x)
  (and (pair? x) (eq? (cadr x) '*)))
(define (multiplier p) (car p))
(define (multiplicand p)
  (if (null? (cdddr p))
      (caddr p)
      (cons '* (cddr p))))

(define (exponentiation? x)
  (and (pair? x) (eq? (car x) '**)))
(define (base s) (cadr s))
(define (exponent s) (caddr s))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))

        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))

        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))

        ((exponentiation? exp)
         (make-product
          (make-product (exponent exp)
                        (make-exponent (base exp) (- (exponent exp) 1)))
          (deriv (base exp) var)))
        (else
         (error "unknown expression type -- DERIV" exp))))

;; tests taken from
;; http://www.billthelizard.com/2012/04/sicp-256-258-symbolic-differentiation.html
(deriv '(x + 3) 'x) ;; 1
(deriv '(x * y) 'x) ;; y
(deriv '(x + (3 * (x + (y + 2)))) 'x) ;; 4

;; (b)
(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))
(define (addend s) (car s))
(define (augend s)
  (if (null? (cdddr s))
      (caddr s)
      (cddr s)))

(define (product? x)
  (and (pair? x) (eq? (cadr x) '*)))
(define (multiplier p) (car p))
(define (multiplicand p)
  (if (null? (cdddr p))
      (caddr p)
      (cddr p)))

;; again, tests taken from the link above
(deriv '(x + 3 * (x + y + 2)) 'x) ;; 4
(deriv '(x + 3 * (x + y + 2)) 'y) ;; 3
(deriv '(x + 3) 'x) ;; 1
(deriv '(x * y) 'x) ;; y
