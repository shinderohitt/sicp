;; Modify your reverse procedure of exercise 2.18 to produce
;; a deep-reverse procedure that takes a list as argument and
;; returns as its value the list with its elements reversed and
;; with all sublists deep-reversed as well. For example,

;; (define x (list (list 1 2) (list 3 4)))

;; x
;; ((1 2) (3 4))

;; (reverse x)
;; ((3 4) (1 2))

;; (deep-reverse x)
;; ((4 3) (2 1))


(define (deep-reverse l)
  (define (do-reverse lat r)
    (cond ((null? lat) r)
          ((list? (car lat))
           (do-reverse (cdr lat)
                       (cons (deep-reverse (car lat)) r)))
          (else (do-reverse (cdr lat) (cons (car lat) r)))))
  (do-reverse l '()))

(deep-reverse '((4 3 (1 2 3)) (2 1)))
;; ((1 2) ((3 2 1) 3 4))
