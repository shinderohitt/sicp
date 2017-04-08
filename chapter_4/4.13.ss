;; Exercise 4.13.  Scheme allows us to create new bindings for variables
;; by means of define, but provides no way to get rid of
;; bindings. Implement for the evaluator a special form make-unbound!
;; that removes the binding of a given symbol from the environment in
;; which the make-unbound! expression is evaluated. This problem is not
;; completely specified. For example, should we remove only the binding
;; in the first frame of the environment? Complete the specification and
;; justify any choices you make.


;; Solution
;; If we allow make-bound to go up the frames trace,
;; and unbound from upper frames, then we are violating
;; scope of other procedures. So we should limit make-unbound
;; to limit to only the front-most frame in the chain

(define (make-unbound! var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (error "Variable not found" var))
            ((eq? var (car vars))
             (begin
               (set-cdr! vars (cdr vars))
               (set-cdr! vals (cdr vals))))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))
