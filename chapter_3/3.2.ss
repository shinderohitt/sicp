
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 3.2.  In software-testing applications, it is useful to be    ;;
;; able to count the number of times a given procedure is called during   ;;
;; the course of a computation. Write a procedure make-monitored that     ;;
;; takes as input a procedure, f, that itself takes one input. The result ;;
;; returned by make-monitored is a third procedure, say mf, that keeps    ;;
;; track of the number of times it has been called by maintaining an      ;;
;; internal counter. If the input to mf is the special symbol             ;;
;; how-many-calls?, then mf returns the value of the counter. If the      ;;
;; input is the special symbol reset-count, then mf resets the counter to ;;
;; zero. For any other input, mf returns the result of calling f on that  ;;
;; input and increments the counter. For instance, we could make a        ;;
;; monitored version of the sqrt procedure:                               ;;
;;                                                                        ;;
;; (define s (make-monitored sqrt))                                       ;;
;;                                                                        ;;
;; (s 100)                                                                ;;
;; 10                                                                     ;;
;;                                                                        ;;
;; (s 'how-many-calls?)                                                   ;;
;; 1                                                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(define (make-monitored fn)
  (let ((counter 0))
    (define (default arg)
      (begin
        (set! counter (+ counter 1))
        (fn arg)))
    (define (how-many-calls?) counter)
    (define (reset-count)
      (set! counter 0))
    (lambda (m)
      (cond ((eq? m 'how-many-calls?) (how-many-calls?))
            ((eq? m 'reset-count) (reset-count))
            (else (default m))))))


(define s (make-monitored sqrt))
(s 100) ;; 10
(s 'how-many-calls?) ;; 1
(s 'reset-count)
(s 'how-many-calls?) ;; 0
