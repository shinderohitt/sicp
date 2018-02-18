(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items '()))
(square-list '(1 2 3)) ;; 9 4 1
;; (const item list) prepends the item
;; onto the list. When we cons square on the list things,
;; we are putting the first item of passed in list
;; and so on if we continue, we are reversing the list

;; (1 2 3) => ()
;; (2 3)   => (1)
;; (3)     => (4 1)
;; ()      => (9 4 1)

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items '()))
(square-list '(1 2 3)) ;; (((() . 1) . 4) . 9)
;; The first call in itself is consing the empty
;; list we passed in with square of first item.
;; This continues until there are no more items
;; in the passed in list, creating a nested list
