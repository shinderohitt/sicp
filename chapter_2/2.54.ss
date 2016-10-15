;; Two lists are said to be equal? if they contain equal elements
;; arranged in the same order. For example,

;; (equal? '(this is a list) '(this is a list))

;; is true, but

;; (equal? '(this is a list) '(this (is a) list))

;; is false. To be more precise, we can define equal? recursively in terms of
;; the basic eq? equality of symbols by saying that a and b are equal?
;; if they are both symbols and the symbols are eq?, or if they are both lists
;; such that (car a) is equal? to (car b) and (cdr a) is equal? to (cdr b).
;; Using this idea, implement equal? as a procedure


(define (equal? lat1 lat2)
  (cond ((and (null? lat1) (null? lat2)) #t)
        ((or (null? lat1) (null? lat2)) #f)
        ((and (symbol? (car lat1))
              (symbol? (car lat2))
              (eq? (car lat1) (car lat2)))
         (equal? (cdr lat1) (cdr lat2)))
        (else #f)))

(equal? '(this is a list) '(this is a list)) ;; #t
(equal? '(this is a list) '(this (is a) list)) ;; #f