;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 4.7.  Let* is similar to let, except that the bindings of the ;;
;; let variables are performed sequentially from left to right, and each  ;;
;; binding is made in an environment in which all of the preceding        ;;
;; bindings are visible. For example                                      ;;
;;                                                                        ;;
;; (let* ((x 3)                                                           ;;
;;        (y (+ x 2))                                                     ;;
;;        (z (+ x y 5)))                                                  ;;
;;   (* x z))                                                             ;;
;;                                                                        ;;
;; returns 39. Explain how a let* expression can be rewritten as a set of ;;
;; nested let expressions, and write a procedure let*->nested-lets that   ;;
;; performs this transformation. If we have already implemented let       ;;
;; (exercise 4.6) and we want to extend the evaluator to handle let*, is  ;;
;; it sufficient to add a clause to eval whose action is                  ;;
;;                                                                        ;;
;; (eval (let*->nested-lets exp) env)                                     ;;
;;                                                                        ;;
;; or must we explicitly expand let* in terms of non-derived expressions? ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define (let? exp)
  (tagged-list? exp 'let))
(define (let*? exp)
  (tagged-list? exp 'let*))

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

(define (make-let pairs body)
  (list ('let pairs body)))

(define (make-let* pairs body)
  (if (null? pairs)
      body
      (make-let (car pairs)
                (make-let* (cdr pairs) body))))

(define (let*->nested-lets exp)
  (let ((pairs (let-pairs exp))
        (body (let-body exp)))
    (make-let* pairs body)))

;; condition to be added in eval to support let*
((let*? exp) (eval (let*->nested-lets exp) env))
