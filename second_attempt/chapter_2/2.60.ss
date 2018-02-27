;; Exercise 2.60.  We specified that a set would be represented as a list
;; with no duplicates. Now suppose we allow duplicates. For instance, the
;; set {1,2,3} could be represented as the list (2 3 2 1 3 2 2). Design
;; procedures element-of-set?, adjoin-set, union-set, and
;; intersection-set that operate on this representation. How does the
;; efficiency of each compare with the corresponding procedure for the
;; non-duplicate representation? Are there applications for which you
;; would use this representation in preference to the non-duplicate one?

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (union-set s1 s2)
  (append s1 s2))


;; element-of-set won't be affected as we might still have to
;; do more comparisons (more than n in worst case which depends
;; on the duplications), but it also increases the probability
;; of finding the element earlier because its copy might be available
;; earlier in the list.

;; fastest would be adjoin-set where we just cons the element in the set
;; because we don't care about duplication, making it O(1) operation

;; union would also become faster, we just need to append one set
;; with another here. which is roughly O(n) operation

;; it shouldn't affect adjoin-set's performance as the constrain
;; on intersection itself is to have only the common elements from
;; both sets. so we need to do comparisons.

;; This representation might be useful where we need faster unions
;; and adjoins
