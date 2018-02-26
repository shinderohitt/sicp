;; 58, a.
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (=number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))

(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))

(define (addend s) (car s))
(define (augend s)
  (caddr s))

(define (product? x)
  (and (pair? x) (eq? (cadr x) '*)))
(define (multiplier p) (car p))
(define (multiplicand s)
  (caddr s))


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
        (else
         (error "unknown expression type -- DERIV" exp))))

(deriv '((x * y) * (x + 3)) 'x) ;; ((x * y) + (y * (x + 3)))
(deriv '(x * y) 'x) ;; y
(deriv '(x + 3) 'x) ;; 1


;; +------------------------------------------+
;; +--- WIP ---+
;; b. part
;; (define ops-by-precedence '(** * + -))
;; (define (ops-in-exp exp)
;;   (cond ((null? exp) '())
;;         ((member (car exp) ops-by-precedence)
;;          (cons (car exp) (ops-in-exp (cdr exp))))
;;         (else (ops-in-exp (cdr exp)))))

;; (define (next-op exp)
;;   (let ((ops-list (ops-in-exp exp)))
;;     (define (iter l)
;;       (if (member (car l) ops-list)
;;           (car l)
;;           (iter (cdr l))))
;;     (iter ops-by-precedence)))

;; (define (return-1 lst)
;;   (if (= (length lst) 1)
;;       (car lst)
;;       lst))
;; (define (right-of elem lst)
;;   (cond ((null? lst) '())
;;         ((eq? elem (car lst)) (return-1 (cdr lst)))
;;         (else (right-of elem (cdr lst)))))

;; (define (left-of elem lst)
;;   (define (iter left-side curs)
;;     (cond ((null? curs) '())
;;           ((eq? elem (car curs)) (return-1 left-side))
;;           (else (iter
;;                  (append left-side (list (car curs)))
;;                  (cdr curs)))))
;;   (iter '() lst))

;; (define (make-sum a1 a2)
;;   (cond ((=number? a1 0) a2)
;;         ((=number? a2 0) a1)
;;         ((and (number? a1) (=number? a2)) (+ a1 a2))
;;         (else (list a1 '+ a2))))

;; (define (make-product m1 m2)
;;   (cond ((or (=number? m1 0) (=number? m2 0)) 0)
;;         ((=number? m1 1) m2)
;;         ((=number? m2 1) m1)
;;         ((and (number? m1) (number? m2)) (* m1 m2))
;;         (else (list m1 '* m2))))

;; (define (sum? x)
;;   (and (pair? x) (eq? (next-op x) '+)))

;; ;; addent is the left part of +
;; ;; augent would be the right
;; (define (addend s)
;;   (left-of '+ s))
;; (define (augend s)
;;   (right-of '+ s))

;; (define (product? x)
;;   (and (pair? x) (eq? (next-op x) '*)))
;; (define (multiplier p)
;;   (left-of '* p))
;; (define (multiplicand s)
;;   (right-of '* s))


;; (define (deriv exp var)
;;   (cond ((number? exp) 0)
;;         ((variable? exp)
;;          (if (same-variable? exp var) 1 0))
;;         ((sum? exp)
;;          (make-sum (deriv (addend exp) var)
;;                    (deriv (augend exp) var)))
;;         ((product? exp)
;;          (make-sum
;;            (make-product (multiplier exp)
;;                          (deriv (multiplicand exp) var))
;;            (make-product (deriv (multiplier exp) var)
;;                          (multiplicand exp))))
;;         (else
;;          (error "unknown expression type -- DERIV" exp))))

;; (deriv '(x * 3 + (x + y + 2)) 'x)
