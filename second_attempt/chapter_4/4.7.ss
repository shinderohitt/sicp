(define (last-exp? seq) (null? (cdr seq)))
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

;; (put 'let (lambda (exp env) (EVAL (let->combination exp) env)))

(define (make-let let-pairs let-body)
  (list 'let let-pairs let-body))

(define (nest-let* let-pairs let-body)
  (if (last-exp? let-pairs)
      (let->combination (make-let let-pairs let-body))
       (make-let (list (car let-pairs))
                 (nest-let* (cdr let-pairs) let-body))))

(define (let*->nested-lets exp)
  (nest-let* (let-pairs-list exp) (let-body exp)))

;; (define l '(let ((a 1)
;;                  (b 2)
;;                  (c 3))
;;              (+ a b c)))

;; (let*->nested-lets l)
;; ;; (let ((a 1))
;; ;;   (let ((b 2))
;; ;;     ((lambda (c) (+ a b c)) 3)))


(put 'let* (lambda (exp env) (EVAL (let*->nested-lets exp) env)))
