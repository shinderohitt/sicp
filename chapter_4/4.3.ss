;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 4.3.  Rewrite eval so that the dispatch is done in           ;;
;; data-directed style. Compare this with the data-directed              ;;
;; differentiation procedure of exercise 2.73. (You may use the car of a ;;
;; compound expression as the type of the expression, as is appropriate  ;;
;; for the syntax implemented in this section.) .                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; evan definition from the book
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))



;; eval -- data-directed style
(put 'eval 'quote lookup-variable-value)
(put 'eval 'set! eval-assignment)
(put 'eval 'define eval-definition)
(put 'eval 'if eval-if)

(put 'eval 'lambda
     (lambda (exp env)
       (make-procedure (lambda-parameters exp)
                       (lambda-body exp)
                       env)))

(put 'eval 'begin
     (lambda (exp env)
       (eval-sequence (begin-actions exp) env)))

(put 'eval 'cond?
     (lambda (exp env)
       (eval (cond->if exp) env)))

(define (eval exp env)
  (cond ((self-evaluating?) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((get 'eval (car exp))
         (apply (get 'eval (car exp)) exp env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))
