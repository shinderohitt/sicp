;; (define l '(letrec
;;                ((fact
;;                  (lambda (n)
;;                    (if (= n 1)
;;                        1
;;                        (* n (fact (- n 1)))))))
;;              (fact 10)))

(define (letrec? expr) (tagged-list? expr 'letrec))
(define (letrec-pairs expr) (cadr expr))
(define (letrec-body expr) (cddr expr))

(define (letrec-vars expr)
  (map car (letrec-pairs expr)))
(define (letrec-var-inits expr)
  (map cadr (letrec-pairs expr)))

(define (letrec->let expr)
  (append
   (list
    'let
    (map (lambda (var) (list var ''*unassigned*)) (letrec-vars expr)))
   (map
    (lambda (var init-exp) (list 'set! var init-exp))
    (letrec-vars expr)
    (letrec-var-inits expr))
   (letrec-body expr)))

;; (letrec->let l)


;; A "let" expression is translated into a lambda, having lets initial variables
;; as parameters to the translated lambda function.
;; For example,

;; (let ((a 1)
;;       (b 2)
;;       (c 3))
;;   (+ a b c))

;; would be translated into a

;; ((lambda (a b c) (+ a b c)) 1 2 3)

;; A similar transformation won't work out for internal definitions. If we take the
;; same example as above, it would similarly be translated as

;; ((lambda (fact) (fact 10)) (lambda (n)
;;                               (if (= n 0)
;;                                   1
;;                                   (* n (fact (- n 1))))))

;; This won't work, because "fact" inside of the passed in lambda points to nothing.
;; It's not a defined variable.
