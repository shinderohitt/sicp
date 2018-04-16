

;; a
;; Here, we return values based on the parameter,
;; which is not tagged (atomic value).

;; b
(define (derivatives)
  (define (variable? x) (symbol? x))
  (define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))
  (define (make-sum a1 a2) (list '+ a1 a2))

  (define (make-product m1 m2) (list '* m1 m2))
  (define (sum? x)
    (and (pair? x) (eq? (car x) '+)))
  (define (addend s) (cadr s))
  (define (augend s) (caddr s))
  (define (product? x)
    (and (pair? x) (eq? (car x) '*)))
  (define (multiplier p) (cadr p))
  (define (multiplicand p) (caddr p))

  (define (deriv-mul exp var)
    (make-sum
     (make-product (multiplier exp)
                   (deriv (multiplicand exp) var))
     (make-product (deriv (multiplier exp) var)
                   (multiplicand exp))))

  (define (deriv-sum exp var)
    (make-sum (deriv (addent exp) var)
              (deriv (augent exp) var)))

  (define (deriv-exp exp var)
    (make-product
     (make-product (exponent exp)
                   (make-exponent
                    (base exp)
                    (- (exponent exp) 1)))
     (deriv (base exp) var)))

  (put 'deriv '+ deriv-sum)
  (put 'deriv '* deriv-mul)
  (put 'deriv '** deriv-exp)
  'done)

;; d
;; ops-table is a two dimetional table in which,
;; it wouldn't matter how we store the values
;; ie, [type][op] vs. [op][type]

;; changing puts to look like
;; (put '+ 'deriv deriv-sum) should make it work
