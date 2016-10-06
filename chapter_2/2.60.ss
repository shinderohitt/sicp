;; Exercise 2.60.  We specified that a set would be represented as a list
;; with no duplicates. Now suppose we allow duplicates.

;; For instance, the set {1,2,3} could be represented
;; as the list (2 3 2 1 3 2 2). Design procedures element-of-set?, adjoin-set,
;; union-set, and intersection-set that operate on this representation.

;; How does the efficiency of each compare with the corresponding procedure
;; for the non-duplicate representation? Are there applications for which
;; you would use this representation in preference to the non-duplicate one?


(define (element-of-set x set)
  (cond ((null? set) #f)
        ((equal? x (car set)) #t)
        (else
         (element-of-set x (cdr set)))))

(define (adjoin-set x set) (cons x set))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (union-set set1 set2) (append set1 set2))


;; Since we are allowed to have duplicates, this makes it easy
;; to write adjoin-set. Here, we do not need to worry whether
;; the given element is present in the set or not. We simply cons
;; it over the target set.

;; This avoids calls to element-of-set, and is a single operation,
;; hence the complexity changes from O(n) to (1).


;; Similarly, for union-set, we simply append given sets.
;; append procedure takes O(n) time, so union-set becomes a (n)
;; procedure from (n^2) which it earlier was.


;; In this representation, we don't need to change procedures element-of-set
;; and intersection-set.

;; In terms of complexity, there won't be any difference between these two,
;; because in the worst case they will still need n "steps" for n elements,
;; but it should improve computing performance as there is a better chance
;; of finding a target element in the list with duplicate elements than
;; with a list with no duplicates.

;; However, the cost of this representation is increased memory usage.
