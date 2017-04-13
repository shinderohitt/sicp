;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 4.16.  In this exercise we implement the method just          ;;
;; described for interpreting internal definitions. We assume that the    ;;
;; evaluator supports let (see exercise 4.6).                             ;;
;;                                                                        ;;
;; a.  Change lookup-variable-value (section 4.1.3) to signal an error if ;;
;; the value it finds is the symbol *unassigned*.                         ;;
;;                                                                        ;;
;; b.  Write a procedure scan-out-defines that takes a procedure body and ;;
;; returns an equivalent one that has no internal definitions, by making  ;;
;; the transformation described above.                                    ;;
;;                                                                        ;;
;; c.  Install scan-out-defines in the interpreter, either in             ;;
;; make-procedure or in procedure-body (see section 4.1.3). Which place   ;;
;; is better? Why?                                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; a. modified lookup-variable-value
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (let ((val (car vals)))
               (if (eq? val '*unassigned*)
                   (error "Undefined variable")
                   val)))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))


;; b. scan-out-defines
(define (scan-out-defines procedure-body)

  (define (define-exps body)
    (cond ((null? body) '())
          ((definition? (car body))
           (cons (car body) (define-exps (cdr body))))
          (else (define-exps (cdr body)))))

  (define (no-define-exps body)
    (cond ((null? body) '())
          ((not (definition? (car body)))
           (cons (car body) (define-exps (cdr body))))
          (else (define-exps (cdr body)))))

  (define (define-var-names define-exps)
    (map definition-variable define-exps))

  (define (define-to-set define-exp)
    (list
     'set!
     (definition-variable define-exp)
     (definition-value define-exps)))

  (let* ((define-exps (define-exps procedure-body))
         (define-names (define-var-names define-exps))
         (pairs (map (lambda (var) (list var '*unassigned*))))
         (defines-to-sets (map define-to-set define-exps))
         (without-defines-body (no-define-exps procedure-body))
         (modified-body (cons defines-to-sets without-defines-body)))
    (if (null? define-exps)
        procedure-body
        (make-let pairs modified-body))))
