;; Machine
(define (make-machine ops
                      controller-text)
  (let ((machine (make-new-machine)))
    (for-each (lambda (register-name)
                ((machine 'allocate-register)
                 register-name))
              (regs-from-controller-text controller-text))
    ((machine 'install-operations) ops)
    ((machine 'install-instruction-sequence)
     (assemble controller-text machine))
    machine))

(define (regs-from-controller-text controller-text)
  (if (null? controller-text)
      '()
      (let ((first (car controller-text))
            (rest (cdr controller-text)))
        (cond ((symbol? first)
               (regs-from-controller-text rest))
              ((tagged-list? first 'assign)
               (cons (assign-reg-name first) (regs-from-controller-text rest)))
              (else
               (regs-from-controller-text rest))))))
