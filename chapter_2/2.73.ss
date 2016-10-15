
;; from section 2.4.3

;; Exercise 2.73.  Section 2.3.2 described a program that performs
;; symbolic differentiation:

;; (define (deriv exp var)
;;   (cond ((number? exp) 0)
;;         ((variable? exp) (if (same-variable? exp var) 1 0))
;;         ((sum? exp)
;;          (make-sum (deriv (addend exp) var)
;;                    (deriv (augend exp) var)))
;;         ((product? exp)
;;          (make-sum
;;            (make-product (multiplier exp)
;;                          (deriv (multiplicand exp) var))
;;            (make-product (deriv (multiplier exp) var)
;;                          (multiplicand exp))))
;;         <more rules can be added here>
;;         (else (error "unknown expression type -- DERIV" exp))))

;; We can regard this program as performing a dispatch on the type of
;; the expression to be differentiated. In this situation the ``type tag''
;; of the datum is the algebraic operator symbol (such as +) and the operation
;; being performed is deriv. We can transform this program into
;; data-directed style by rewriting the basic derivative procedure as

(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else ((get 'deriv (operator exp)) (operands exp)
                                            var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

;; a.  Explain what was done above.
;; Why can't we assimilate the predicates number? and same-variable?
;; into the data-directed dispatch?

;; The (get 'deriv (operator exp)) procedure looks up for the procedure by
;; the symbol returned by (operator exp). This returns the procedure to be
;; appplied on the (operangs exp) .. (which returns the operands).

;; number? and variable? are the breaking points in this recursive procedure,
;; and are simple operations which are not similar to procedures such as +, *
;; this makes it hard to tag them and use like the other operations


;; (b, and c). Write the procedures for derivatives of sums and products, and
;; the auxiliary code required to install them in the table used by
;; the program above.

;; Helper functions (http://stackoverflow.com/a/19114031)
(define *op-table* (make-hash-table))

(define (put op type proc)
  (hash-table/put! *op-table* (list op type) proc))

(define (get op type)
  (hash-table/get *op-table* (list op type) #f))

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (=number? exp num)
  (and (number? exp) (= exp num)))


(define (install-deriv-package)
  ;; internal procedures
  (define (addend s) (car s))
  (define (augend s) (cadr s))

  (define (multiplier p) (car p))
  (define (multiplicand p) (cadr p))

  (define (base s) (car s))
  (define (exponent s) (cadr s))


  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))

  (define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2))))

  (define (handle-sum exp var)
    (make-sum (deriv (addend exp) var)
              (deriv (augend exp) var)))

  (define (handle-product exp var)
    (make-sum
     (make-product (multiplier exp)
                   (deriv (multiplicand exp) var))
     (make-product (deriv (multiplier exp) var)
                   (multiplicand exp))))

  (define (handle-expon exp var)
    (make-product
     (make-product (exponent exp)
                   (make-exponent
                    (base exp)
                    (- (exponent exp) 1)))
     (deriv (base exp) var)))

  ;; interface to the rest of the system
  (put 'deriv '+  handle-sum)
  (put 'deriv '*  handle-product)
  (put 'deriv '**  handle-expon)
  'done)

(install-deriv-package)
(deriv '(* x (+ x 3)) 'x) ;; (+ x (+ x 3))
;; (deriv '(** x 2) 'x) ;; (* 2 x)

;; d. In this simple algebraic manipulator the type of an expression
;; is the algebraic operator that binds it together. Suppose, however,
;; we indexed the procedures in the opposite way, so that the dispatch line
;; in deriv looked like

;; ((get (operator exp) 'deriv) (operands exp) var)

;; What corresponding changes to the derivative system are required?

;; The only change required is to change (put .. ) expressions in
;; install-deriv-package to look like
;; (put '<operator exp> 'deriv <target exp handle method>)
