;; Exercise 4.20.  Because internal definitions look sequential but are
;; actually simultaneous, some people prefer to avoid them entirely, and
;; use the special form letrec instead. Letrec looks like let, so it is
;; not surprising that the variables it binds are bound simultaneously
;; and have the same scope as each other. The sample procedure f above
;; can be written without internal definitions, but with exactly the same
;; meaning, as

;; (define (f x)
;;   (letrec ((even?
;;             (lambda (n)
;;               (if (= n 0)
;;                   true
;;                   (odd? (- n 1)))))
;;            (odd?
;;             (lambda (n)
;;               (if (= n 0)
;;                   false
;;                   (even? (- n 1))))))
;;     <rest of body of f>))

;; Letrec expressions, which have the form

;; (letrec ((<var1> <exp1>) ... (<varn> <expn>))
;;   <body>)

;; are a variation on let in which the expressions <expk> that provide
;; the initial values for the variables <vark> are evaluated in an
;; environment that includes all the letrec bindings. This permits
;; recursion in the bindings, such as the mutual recursion of even? and
;; odd? in the example above, or the evaluation of 10 factorial with

;; (letrec ((fact
;;           (lambda (n)
;;             (if (= n 1)
;;                 1
;;                 (* n (fact (- n 1)))))))
;;   (fact 10))

;; a. Implement letrec as a derived expression, by transforming a letrec
;; expression into a let expression as shown in the text above or in
;; exercise 4.18. That is, the letrec variables should be created with a
;; let and then be assigned their values with set!.

;; Stole the solution below from --
;; http://community.schemewiki.org/?sicp-ex-4.20
;; then understood the problem ;)

;; a
;; letrec expression
(define (letrec? expr) (tagged-list? expr 'letrec))
(define (letrec-inits expr) (cadr expr))
(define (letrec-body expr) (cddr expr))
(define (declare-variables expr)
  (map (lambda (x) (list (car x) '*unassigned*)) (letrec-inits expr)))
(define (set-variables expr)
  (map (lambda (x) (list 'set! (car x) (cadr x))) (letrec-inits expr)))
(define (letrec->let expr)
  (list 'let (declare-variables expr)
        (make-begin (append (set-variables expr) (letrec-body expr)))))
