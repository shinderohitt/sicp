
(define (or-gate a1 a2 output)
  (define (logical-or in1 in2)
    (cond
     ;; First two conditions check if values are proper
     ;; ie, they both have to be either 0 or 1
     ((not (or (= in1 0) (= in1 1)))
      (error "Invalid input 1 value"))
     ((not (or (= in1 0) (= in1 1)))
      (error "Invalid input 1 value"))
     ((= in1 1) 1)
     ((= in2 1) 1)
     (else 0)))
  (define (or-action-procedure)
    (let ((new-value
           (logical-or (get-signal a1) (get-signal a2))))
      (after-delay or-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)
