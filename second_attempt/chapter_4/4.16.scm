;; 1
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop
              (enclosing-environment env)))
            ((eq? var (car vars))
             (if (eq? (car vals) '*unassigned*)
                 (error "ERROR: Unassigned " var)
                 (var vals)))
            (else (scan (cdr vars)
                        (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

;; 2
;; snippets from the book

(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))
(define (definition? exp)
  (tagged-list? exp 'define))

(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))

(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp)
                   (cddr exp))))

(define (scan-out-defines body)
  (define (non-defines body)
    (filter (lambda (exp) (not (definition? exp))) body))
  (define (defines body)
    (filter definition? body))
  (define (define-unassigned exp)
    (list (definition-variable exp) '*unassigned*))
  (define (set-define exp)
    (list 'set! (definition-variable exp) (definition-value exp)))
  (let ((body-non-defines (non-defines body))
        (body-defines (defines body)))
    (append (list 'let
                  (map define-unassigned body-defines))
            (map set-define body-defines)
            body-non-defines)))

;; 3
(define (make-procedure parameters body env)
  (list 'procedure parameters (scan-out-defines body) env))
;; It makes more sense to install it in make-procedure, because we would have to
;; call scan-out-defines every time we call a given procedure
