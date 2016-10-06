;; Exercise 2.59.  Implement the union-set operation for
;; the unordered-list representation of sets.

(define (element-of-set x set)
  (cond ((null? set) #f)
        ((equal? x (car set)) #t)
        (else
         (element-of-set x (cdr set)))))

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((element-of-set (car set1) set2)
         (union-set (cdr set1) set2))
        (else (cons (car set1)
                    (union-set (cdr set1) set2)))))

(union-set '(shaktimaan is a hero)
           '(is he not?))
;; (shaktimaan a hero is he not?)
