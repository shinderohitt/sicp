;; The solution below only removes reference
;; the the variables that is being unbound.
(define (make-unbound! var env)
  (let ((frame (first-frame env)))
    (define (scan var vars vals)
      (cond ((null? vars) (error "VAR NOT FOUND"))
            ((eq? var (car vars))
             (begin
               (set-car! vars (cadr vars))
               (set-car! vals (cadr vals))))
            (else (scan var (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))


;; We should not modify bounding frames
;; because those may be used by the calling/parent processes
