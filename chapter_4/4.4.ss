;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 4.4.  Recall the definitions of the special forms and and or  ;;
;; from chapter 1:                                                        ;;
;;                                                                        ;;
;; and: The expressions are evaluated from left to right. If any          ;;
;; expression evaluates to false, false is returned; any remaining        ;;
;; expressions are not evaluated. If all the expressions evaluate to true ;;
;; values, the value of the last expression is returned. If there are no  ;;
;; expressions then true is returned.                                     ;;
;;                                                                        ;;
;; or: The expressions are evaluated from left to right. If any           ;;
;; expression evaluates to a true value, that value is returned; any      ;;
;; remaining expressions are not evaluated. If all expressions evaluate   ;;
;; to false, or if there are no expressions, then false is returned.      ;;
;;                                                                        ;;
;; Install and and or as new special forms for the evaluator by defining  ;;
;; appropriate syntax procedures and evaluation procedures eval-and and   ;;
;; eval-or. Alternatively, show how to implement and and or as derived    ;;
;; expressions.                                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; assuming {true, false} are bound to implemented
;; language's "true" and "false" values

(define (eval-and exps env)
  (cond ((no-operands? exps) true)
        ((last-exp? exps)
         (true? (eval (first-exp exps) env)))
        (else
         (if (true? (eval (first-exp exps) env))
             (eval-and (rest-exps exps) env)
             false))))

(define (eval-or exps env)
  (cond ((no-operands? exps) false)
        ((last-exp? exps)
         (true? (eval (first-exp exps) env)))
        (else
         (if (true? (eval (first-exp exps) env))
             true
             (eval-or (rest-exps exps) env)))))


;; install methods
;; (using solution from 4.3; for data-directed eval)

(put 'eval 'and
     (lambda (exps env)
       (eval-and (cdr exps))))

(put 'eval 'or
     (lambda (exps env)
       (eval-or (cdr exps))))


;; no change to eval method is required
