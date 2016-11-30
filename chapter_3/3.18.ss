;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 3.18.  Write a procedure that examines a list and determines ;;
;; whether it contains a cycle, that is, whether a program that tried to ;;
;; find the end of the list by taking successive cdrs would go into an   ;;
;; infinite loop. Exercise 3.13 constructed such lists.                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




(define (has-cycle? lat)
  (let ((seen '()))

    (define (helper lt)
      (cond
       ((null? lt) #f)
       ((memq (car lt) seen) #t)
       (else
        (begin
          (set! seen (cons (car lt) seen))
          (helper (cdr lt))))))

    (helper lat)))


;; tests below taken from
;; https://wizardbook.wordpress.com/2010/12/16/exercise-3-18/
(define l1 (list 'a 'b 'c))
(define l2 (list 'a 'b 'c))
(set-cdr! (cdr (cdr l2)) l2)
(define l3 (list 'a 'b 'c 'd 'e))
(set-cdr! (cdddr l3) (cdr l3))
(define l4 (list 'a 'b 'c 'd 'e))
(set-car! (cdddr l4) (cddr l4))

(has-cycle? l1)
;; #f

(has-cycle? l2)
;; #t
