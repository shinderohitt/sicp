;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 4.8.  ``Named let'' is a variant of let that has the form    ;;
;;                                                                       ;;
;; (let <var> <bindings> <body>)                                         ;;
;;                                                                       ;;
;; The <bindings> and <body> are just as in ordinary let, except that    ;;
;; <var> is bound within <body> to a procedure whose body is <body> and  ;;
;; whose parameters are the variables in the <bindings>. Thus, one can   ;;
;; repeatedly execute the <body> by invoking the procedure named         ;;
;; <var>. For example, the iterative Fibonacci procedure (section 1.2.2) ;;
;; can be rewritten using named let as follows:                          ;;
;;                                                                       ;;
;; (define (fib n)                                                       ;;
;;   (let fib-iter ((a 1)                                                ;;
;;                  (b 0)                                                ;;
;;                  (count n))                                           ;;
;;     (if (= count 0)                                                   ;;
;;         b                                                             ;;
;;         (fib-iter (+ a b) a (- count 1)))))                           ;;
;;                                                                       ;;
;; Modify let->combination of exercise 4.6 to also support named let.    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define (let? exp)
  (tagged-list? exp 'let))

(define (let*? exp)
  (tagged-list? exp 'let*))

;; modified let-pairs, and let-body
;; to check if the let is named or not,
;; and respond accordingly

(define (named-let?)
  (eq? (length exp) 4))

(define (let-pairs exp)
  (if (named-let? exp)
      (cadr exp)
      (caddr exp)))
(define (let-pairs exp)
  (if (named-let? exp)
      (caddr exp)
      (cadddr exp)))

(define (let-name exp)
  (cadr exp))

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


;; Solution to the problem; modified let->combination
(define (let->combination exp)
  (let ((pairs (let-pairs exp))
        (body (let-body exp)))
    (let ((parameters (map car pairs))
          (values (map cadr pairs)))
      (if (named-let? exp)
          (make-let*
           (list (list (let-name exp)
                       (make-lambda parameters body)))
           (list (let-name exp) values))
          (list (make-lambda parameters body) values)))))
