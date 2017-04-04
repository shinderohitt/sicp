Exercise 4.6.  Let expressions are derived expressions, because

(let ((<var1> <exp1>) ... (<varn> <expn>))
  <body>)

is equivalent to

((lambda (<var1> ... <varn>)
   <body>)
 <exp1>

 <expn>)

Implement a syntactic transformation let->combination that reduces
evaluating let expressions to evaluating combinations of the type
shown above, and add the appropriate clause to eval to handle let
expressions.

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
        ((let? exp) (eval (let->combination exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))


(define (let? exp)
  (tagged-list? exp 'let))
(define (let-pairs exp)
  (cadr exp))
(define (let-body exp)
  (caddr exp))

(define (let->combination exp)
  (let ((pairs (let-pairs exp))
        (body (let-body exp)))
    (let ((parameters (map car pairs))
          (values (map cadr pairs)))
      (list (make-lambda parameters body) values))))
