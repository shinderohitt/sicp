
;; 1.
;; Since our (application? .. ) only checks if the passed in param is a pair,
;; (define x 3) will be considered as a user defined procedure and not
;; a special form. So while trying to evaluate it as a procedure application,
;; it will again try to evaluate the "oprator" which will be define.

;; in this iteration (variable? .. ) will return true, because define is a symbol,
;; and the it will try to look up "define" in the env, where it should fail.

;; 2.
(define (application? exp)
  (tagged-list? exp 'call))
(define (operator exp) (cadr exp))
(define (operands exp) (cddr exp))
