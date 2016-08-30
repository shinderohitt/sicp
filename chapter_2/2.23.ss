
;; (for-each (lambda (x) (newline) (display x))
;;           (list 57 321 88))
;; 57
;; 321
;; 88

;; Give an implementation of for-each.

;; Don't know what to return as a value of the function
;; when we are done. Leaving #t as a placeholder :)
(define (for-each x lat)
  (if (null? lat)
      #t
      (and (x (car lat))
           (for-each x (cdr lat)))))


(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))

;; 7
;; 321
;; 88
;; ;Value: #t
