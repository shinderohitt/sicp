(define new-rand
  (let ((x (random-init)))
    (lambda (op)
      (cond ((eq? op 'generate)
             (begin (set! x (rand-update x)) x))
            ((eq? op 'reset)
             (lambda (with-val)
               (set! x with-val)
               with-val))))))
