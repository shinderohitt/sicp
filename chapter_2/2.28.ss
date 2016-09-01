;; Write a procedure fringe that takes as argument a tree
;; (represented as a list) and returns a list whose elements are all
;; the leaves of the tree arranged in left-to-right order. For example,

;; (define x (list (list 1 2) (list 3 4)))

;; (fringe x)
;; (1 2 3 4)

;; (fringe (list x x))
;; (1 2 3 4 1 2 3 4)


;; (define (fringe lat)
;;   (cond ((null? lat) lat)
;;         ((list? (car lat))
;;          (cons (fringe (car lat))
;;                (fringe (cdr lat))))
;;         (else (car lat))))
;; failure above

(define (fringe lat)
  (define (fringe-maker lst res)
    (cond ((null? lst) res)
          ((list? lst)
           (fringe-maker (car lst)
                 (fringe-maker (cdr lst) res)))
          (else (cons lst res))))
  (fringe-maker lat '()))


(fringe '((1 2) (3 4))) ;; (1 2 3 4)
