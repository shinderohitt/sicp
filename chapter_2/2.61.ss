
;; Exercise 2.61.  Give an implementation of adjoin-set using
;; the ordered representation. By analogy with element-of-set?
;; show how to take advantage of the ordering to produce a procedure that
;; requires on the average about half as many steps as with
;; the unordered representation.


(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1
                     (intersection-set (cdr set1)
                                       (cdr set2))))
              ((< x1 x2)
               (intersection-set (cdr set1) set2))
              ((< x2 x1)
               (intersection-set set1 (cdr set2)))))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((element-of-set? x set) set)
        ((> (car set) x) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(adjoin-set 4 '(1 2 3 5))
;; (1 2 3 4 5)

;; Since element-of-set? improves its performance by a factor of 2
;; with the ordered set representation, it also improves the performance
;; of adjoin-set by the same factor
