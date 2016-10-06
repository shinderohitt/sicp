;; Exercise 2.62.  Give a (n) implementation of union-set
;; for sets represented as ordered lists.


(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else (let ((x1 (car set1)) (x2 (car set2)))
                (cond
                 ((= x1 x2)
                  (union-set (cdr set1) set2))
                 ((< x1 x2)
                  (cons x1 (union-set (cdr set1) set2)))
                 (else (cons x2 (union-set set1 (cdr set2))))

                 )))))

(union-set '(1 2 3 4 5 7 10) '(5 6 7 8 9 10))
;; (1 2 3 4 5 6 7 8 9 10)

;; union-set is a simple merge of two lists.
;; the conditions being

;; if the tops of two lists are the same,
;; ignore the top of the first list, and include elements from the
;; first list only.

;; also, to keep the sorted order, we need to make sure the smaller
;; elements are inserted after the larger ones (to the front).
