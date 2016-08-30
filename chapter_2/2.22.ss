
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items '()))

(square-list '(1 2 3 4 5)) ;;  (25 16 9 4 1)
;; cons puts its first argument in the beginning
;; of the list which is passed as the second argument
;; and returns this new list.
;; which is the reason why we are getting a reversed list here

;; The list builds as:
;; ()
;; (1)
;; (4 1)
;; (9 4 1)
;; (16 9 4 1)
;; (25 16 9 4 1)



(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items '()))

(square-list '(1 2 3 4 5)) ;; (((((() . 1) . 4) . 9) . 16) . 25)
;; In the case above, Louis is doing cons of answer over an integer
;; for example
;; (cons '(1) 5)
;; which would produce
;; ((1) 5)
