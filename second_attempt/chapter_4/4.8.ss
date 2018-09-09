(define (let-pairs-list exp)
  (if (named-let? exp)
      (cddr exp)
      (cdr exp)))

(define (let-name exp)
  (cadr exp))

(define (let-vars exp)
  (map car (let-pairs-list exp)))
(define (let-var-exps exp)
  (map cadr (let-pairs-list exp)))
(define (let-body exp)
  (if (named-let? exp)
      (cadddr exp)
      (caddr exp)))

(define (named-let? exp)
  (not (list? (cadr exp))))


(define (let->combination exp)
  (let* ((let-vars (let-vars exp))
         (let-var-exps (let-var-exps exp))
         (let-body (let-body exp)))
    (if (named-let? exp)
        (cons (make-lambda
               ;; Add the name to the param list
               (cons (let-name exp) let-vars)
               let-body)
              ;; Add a new lambda body that will be bound to the param added above
              (cons (make-lambda let-vars let-body) let-var-exps))
        (cons (make-lambda let-vars let-body)
              let-var-exps))))

;; (put 'let (lambda (exp env) (EVAL (let->combination exp) env)))


(define (make-let let-pairs let-body)
  (list 'let let-pairs let-body))

(define (nest-let* let-pairs let-body)
  (if (last-pair? let-pairs)
      (let->combination (make-let let-pairs let-body))
      (let->combination
       (make-let (car let-pairs) (foo (cdr let-pairs) let-body)))))

(define (let*->nested-lets exp)
  (nest-let* (let-pairs-list exp) (let-body)))

;; (put 'let* (lambda (exp env) (EVAL (let*->nested-lets exp) env)))
