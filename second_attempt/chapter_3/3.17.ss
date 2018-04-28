(define pairs-table (make-strong-eq-hash-table 10))
(define (update-hash-and-return table obj)
  (if (hash-table/get table obj #f)
      0
      (begin
        (hash-table/put! table obj 1)
        1)))
(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         (update-hash-and-return pairs-table x))))
