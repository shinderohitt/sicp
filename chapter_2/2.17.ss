;; Define a procedure last-pair that returns
;; the list that contains only the last element
;; of a given (nonempty) list

(define (last-pair lat)
  (if (null? (cdr lat))
      (list (car lat))
      (last-pair (cdr lat))))

(last-pair '(1 3)) ;; (3)
