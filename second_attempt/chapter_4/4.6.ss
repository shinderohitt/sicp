(define (let-pairs-list exp) (cadr exp))
(define (let-vars exp)
  (map car (let-pairs-list exp)))
(define (let-var-exps exp)
  (map cadr (let-pairs-list exp)))
(define (let-body exp) (caddr exp))

(define (let->combination exp)
  (let* ((let-vars (let-vars exp))
         (let-var-exps (let-var-exps exp))
         (let-body (let-body exp)))
    (cons (make-lambda let-vars let-body)
          let-var-exps)))

;; (define l '(let ((a 1)
;;                  (b 2)
;;                  (c 3))
;;              (+ a b c)))

;; (let->combination l) ;; ((lambda (a b c) (+ a b c)) 1 2 3)

(put 'let (lambda (exp env) (EVAL (let->combination exp) env)))
