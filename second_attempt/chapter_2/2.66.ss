
;; assuming records are just numbers
(define (key record) record)

;; selectors
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (lookup given-key tree)
  (cond ((null? tree) false)
        ((equal? given-key (entry tree)) given-key)
        ((< given-key (entry tree))
         (lookup given-key (left-branch tree)))
        (else
         (lookup given-key (right-branch tree)))))
