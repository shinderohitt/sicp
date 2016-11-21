;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 3.6.  It is useful to be able to reset a random-number       ;;
;; generator to produce a sequence starting from a given value. Design a ;;
;; new rand procedure that is called with an argument that is either the ;;
;; symbol generate or the symbol reset and behaves as follows:           ;;
;;                                                                       ;;
;; (rand 'generate)                                                      ;;
;; produces a new random number;                                         ;;
;;                                                                       ;;
;; ((rand 'reset) <new-value>)                                           ;;
;; resets the internal state variable to the designated <new-value>.     ;;
;;                                                                       ;;
;; Thus, by resetting the state, one can generate repeatable             ;;
;; sequences. These are very handy to have when testing and debugging    ;;
;; programs that use random numbers.                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; The procedure given in the book
(define rand
  (let ((x 5))
    (lambda ()
      (set! x (rand-update x))
      x)))

;; A solution to the problem above
(define rand
  (let ((x rand-init))
    (lambda (op)
      (cond
       ((eq? op 'generate)
        (begin (set! x (rand-update x)) x))
       ((eq? op 'reset)
        (lambda (new-value)
          (set! x new-value)))))))
