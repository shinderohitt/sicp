(define (make-table)
  (list '*table*))

(define (assoc key records)
  (cond ((null? records) #f)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (lookup keys table)
  (cond ((null? keys) #f)
        ;; If last key, get matching record (or table),
        ;; and return the value/table. false otherwise.
        ((null? (cdr keys))
         (let ((record (assoc (car keys) (cdr table))))
           (if record
               (cdr record)
               #f)))
        (else
         (let ((sub-table (assoc (car keys) (cdr table))))
           (if sub-table
               (lookup (cdr keys) sub-table)
               #f)))))

(define (insert keys value table)
  (if (null? keys)
      (error "Keys should not be an empty list")
      (let ((record (assoc (car keys) (cdr table))))
        ;; Last item in the keys. So just add the value
        ;; if record exists, create a pair if not
        ;; and return
        (cond ((null? (cdr keys))
               (if record
                   (set-cdr! record value)
                   (set-cdr! table
                             (cons (cons (car keys) value) (cdr table)))))
              ;; There are more keys.
              ;; Now only check if the table exists, if it does,
              ;; recurse on it. If not, create one.
              (else
               (if record
                   (insert (cdr keys) value record)
                   (begin
                     (set-cdr! table
                               (cons (cons (car keys) '()) (cdr table)))
                     (insert (cdr keys) value (car (cdr table))))))))))

(define t (make-table))
(insert '(state district) 'satara t)
(lookup '(state district) t)

;; NOTE:
;; There is a bug in the code above.
;; So give the code above has already run, we can't do something like --
;; (insert '(state district village) 'wadwadi t)
;; Because at keys (state district) we have a pair not a table

;; Can't think of a cleaner solution atm than having a pair
;; at the table. One pointing to the list of records, and one
;; at the value for table name key.
