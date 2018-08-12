#lang racket

(define *op-table* (make-hash))
(define (put type proc)
  (hash-set! *op-table* (list type) proc))
(define (get type)
  (hash-ref *op-table* (list type) '()))


(put 'quote (lambda (exp env) (text-of-quotation exp)))
(put 'set! (lambda (exp env) (eval-assignment exp env)))
(put 'define (lambda (exp env) (eval-definition exp env)))
(put 'if (lambda (exp env) (make-procedure
                            (lambda-parameters exp)
                            (lambda-body exp)
                            env)))
(put 'begin (lambda (exp env)
              (eval-sequence (begin-actions exp) env)))

(put 'cond (lambda (exp env)
             (eval (cond->if exp) env)))


(define (EVAL exp env)
  (cond ((self-evaluating? exp)
         exp)
        ((variable? exp)
         (lookup-variable-value exp env))
        ((get (car exp))
         ((get (car exp)) exp env))
        ((application? exp)
         (APPLY (eval (operator exp) env)
                (list-of-values
                 (operands exp)
                 env)))
        (else
         (error "Unknown expression
                 type: EVAL" exp))))
