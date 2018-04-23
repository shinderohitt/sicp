(define (make-monitored fn)
  (let ((counter 0))
    (lambda (fnarg)
      (cond ((eq? fnarg 'how-many-calls?) counter)
            ((eq? fnarg 'reset-count)
             (begin (set! counter 0) counter))
            (else (begin
                    (set! counter (+ counter 1))
                    (fn fnarg)))))))
