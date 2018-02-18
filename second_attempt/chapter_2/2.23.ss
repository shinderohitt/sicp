(define (for-each fn items)
  (if (null? items)
      #t
      (and (fn (car items))
           (for-each fn (cdr items)))))

(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))
