(define (make-operation-exp
         exp machine labels operations)
  (let ((op (lookup-prim
             (operation-exp-op exp)
             operations))
        (aprocs
         (map (lambda (e)
                (make-primitive-exp
                 e machine labels))
              (check-for-label-ops (operation-exp-operands exp)))))
    (lambda () (apply op (map (lambda (p) (p))
                              aprocs)))))

;; errors if there are any (label foo), since
;; such expression are invalid in operations
;; returns the original ops back if there are no labels
(define (check-for-label-ops ops)
  (for-each
   (lambda (op)
     (if (tagged-list? op 'label)
         (error "ERROR: NO labels are allowed in OP")))
   ops)
  ops)
