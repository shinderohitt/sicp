
;; Since implementing scheme evaluates arguments
;; from left to right, the given version could be
;; used for ltr evaluation

(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values
             (rest-operands exps)
             env))))

;; For right-to-left evaluation, we could do a reverse
(define (list-of-values-rtl exps env)
  (if (no-operands? exps)
      '()
      (append (list-of-values-rtl (rest-operands exps env))
              (list (eval (first-operand exps) env)))))
