
;; What would the interpreter print in response to evaluating each of the following expressions?


;; (list 'a 'b 'c)
;;                (a b c)


;; (list (list 'george))
;;                ((george))


;; (cdr '((x1 x2) (y1 y2)))
;;                ((y1 y2))


;; (cadr '((x1 x2) (y1 y2)))
;;                (y1 y2)


;; (pair? (car '(a short list)))
;;                #f
;;                because it will be just - a


(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))
;; (memq 'red '((red shoes) (blue socks)))
;;               #f
;;               because 'red' is not there in the list
;;               it is a list of lists


;; (memq 'red '(red shoes blue socks))
;;               (red shoes blue socks)
