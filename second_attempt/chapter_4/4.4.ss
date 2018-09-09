(define (eval-and exps env)
  (cond ((null? exps) true)
        ((last-exp? exps) (true? (eval (car exps) env)))
        ((not (true? (eval (car exps) env))) false)
        (else
         (eval-and (cdr exps) env))))

(define (eval-or exps env)
  (cond ((null? exps) false)
        ((true? (eval (car exps) env))
         (eval (car exps) env))          ;; evaluating it twice here, could be avoided
        (else (eval-or (cdr exps) env))))

(define and-exps cdr)
(define or-exps cdr)

;; To install
(put 'if (lambda (exp env) (eval-and (and-exps exp) env)))
(put 'or (lambda (exp env) (eval-or (or-exps exp) env)))
