;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 3.29.  Another way to construct an or-gate is as a compound ;;
;; digital logic device, built from and-gates and inverters. Define a   ;;
;; procedure or-gate that accomplishes this. What is the delay time of  ;;
;; the or-gate in terms of and-gate-delay and inverter-delay?           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value
           (logical-and (get-signal a1) (get-signal a2))))
      (after-delay and-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)

(define (inverter input output)
  (define (invert-input)
    (let ((new-value (logical-not (get-signal input))))
      (after-delay inverter-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! input invert-input)
  'ok)

(define (or-gate a1 a2 output)
  (let ((z1 (make-wire))
        (z2 (make-wire))
        (z3 (make-wire)))
    (inverter a1 z1)
    (inverter a2 z2)
    (and-gate z1 z2 z3)
    (inverter z3 output))
  'ok)


;; The delay would be
;; (2 x invertar-delay) + (and-gate-delay)
